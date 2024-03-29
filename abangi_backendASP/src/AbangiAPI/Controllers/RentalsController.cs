using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Dtos;
using AbangiAPI.Models;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.JsonPatch;
using Swashbuckle.AspNetCore.Annotations;
using System.Net;


namespace AbangiAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [ApiExplorerSettings(IgnoreApi=true)]
    public class RentalsController : ControllerBase
    {
        private readonly IRentalAPIRepo _repository;
        private readonly IMapper _mapper;
        public RentalsController(IRentalAPIRepo repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }
        [HttpGet]
        [AllowAnonymous]
        [SwaggerOperation("GetAllRentals")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult<IEnumerable<RentalInformation>>> GetAllRentals()
        {
            var rentals = await _repository.GetAllRentals();
            return Ok(rentals);
        }
        [HttpGet("{id}" , Name = "GetRentalById")]
        [AllowAnonymous]
        [SwaggerOperation("GetRentalById")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult<RentalInformation>> GetRentalById(int id)
        {
            var rental = await _repository.GetRentalById(id);
            if(rental == null)
            {
                return NotFound();
            }
            return Ok(rental);
        }

       [HttpPost]
       [SwaggerOperation("CreateRental")]
       [SwaggerResponse((int)HttpStatusCode.OK)]
       [SwaggerResponse((int)HttpStatusCode.NotFound)]


         public  ActionResult<RentalReadDto> CreateRental([FromBody] RentalCreateDto rentalCreateDto)
         {
             if(ModelState.IsValid)
             {
                 var rentalModel = _mapper.Map<Rental>(rentalCreateDto);
              _repository.CreateRental(rentalModel);
               _repository.SaveChanges();
              var rentalReadDto = _mapper.Map<RentalReadDto>(rentalModel);
              return CreatedAtRoute(nameof(GetRentalById), new {id = rentalReadDto.RentalId}, rentalReadDto);
             }
             else
             {
                return BadRequest(ModelState);
             }
         }
            [HttpGet("GetRentalByUserId/{id}")]
            [AllowAnonymous]
            [SwaggerOperation("GetRentalByUserId")]
            [SwaggerResponse((int)HttpStatusCode.OK)]
            [SwaggerResponse((int)HttpStatusCode.NotFound)]
            public async Task<ActionResult<IEnumerable<RentalInformation>>> GetRentalByUserId(int id)
            {
                var rental = await _repository.GetRentalByUserId(id);
                if(rental == null)
                {
                    return NotFound();
                }
                return Ok(rental);
            }

            [HttpGet("GetRentalByOwnerId/{id}")]
            [SwaggerOperation("GetRentalByOwnerId")]
            [SwaggerResponse((int)HttpStatusCode.OK)]
            [SwaggerResponse((int)HttpStatusCode.NotFound)]
            public async Task<ActionResult<IEnumerable<RentalInformation>>> GetRentalByOwnerId(int id)
            {
                var rental = await _repository.GetRentalByOwnerId(id);
                if(rental == null)
                {
                    return NotFound();
                }
                return Ok(rental);
            }
            [HttpPatch("{id}")]
            [SwaggerOperation("UpdateRental")]
            [SwaggerResponse((int)HttpStatusCode.OK)]
            [SwaggerResponse((int)HttpStatusCode.NotFound)]
            public async Task<ActionResult> UpdateRental(int id, [FromBody] JsonPatchDocument<RentalUpdateDto> patchDoc)
            {
                var rentalModelFromRepo = await _repository.GetIdPatch(id);
                if(rentalModelFromRepo == null)
                {
                    return NotFound();
                }
                var rentalToPatch = _mapper.Map<RentalUpdateDto>(rentalModelFromRepo);
                patchDoc.ApplyTo(rentalToPatch, ModelState);
                if(!TryValidateModel(rentalToPatch))
                {
                    return ValidationProblem(ModelState);
                }
                _mapper.Map(rentalToPatch, rentalModelFromRepo);
                _repository.UpdateViaPatch(rentalModelFromRepo);
                _repository.SaveChanges();
                return NoContent();
            }
            [HttpDelete("{id}")]
            [SwaggerOperation("DeleteRental")]
            [SwaggerResponse((int)HttpStatusCode.OK)]
            [SwaggerResponse((int)HttpStatusCode.NotFound)]
              public async Task<ActionResult> DeleteRental(int id)
              {
                var rentalModelFromRepo = await _repository.GetIdPatch(id);
                if(rentalModelFromRepo == null)
                {
                     return NotFound();
                }
                _repository.DeleteRental(rentalModelFromRepo);
                _repository.SaveChanges();
                return NoContent();
              }
    }
}
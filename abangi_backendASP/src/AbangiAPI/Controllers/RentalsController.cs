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

namespace AbangiAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
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
        public async Task<ActionResult<IEnumerable<RentalInformation>>> GetAllRentals()
        {
            var rentals = await _repository.GetAllRentals();
            return Ok(rentals);
        }
        [HttpGet("{id}" , Name = "GetRentalById")]
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
       [AllowAnonymous]
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
            public async Task<ActionResult<RentalInformation>> GetRentalByUserId(int id)
            {
                var rental = await _repository.GetRentalByUserId(id);
                if(rental == null)
                {
                    return NotFound();
                }
                return Ok(rental);
            }
    }
}
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Dtos;
using AbangiAPI.Models;
using AutoMapper;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Net;
using Swashbuckle.AspNetCore.Annotations;

namespace AbangiAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [ApiExplorerSettings(IgnoreApi=true)]
    public class RentalMethodsController : ControllerBase
    {
        private readonly IRentalMethodAPIRepo _repository;
        private readonly IMapper _mapper;
        public RentalMethodsController(IRentalMethodAPIRepo repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }
           
        [HttpGet]
        [SwaggerOperation("GetAllRentalMethods")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult<IEnumerable<RentalMethod>>> GetAll()
        {
            var rentalMethods = await _repository.GetAllRentalMethods();
            return Ok(rentalMethods);
        }

        [HttpPost]
        [SwaggerOperation("CreateRentalMethod")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]

        public ActionResult<RentalMethod> CreateRentalMethod(RentalMethod rentalMethod)
        {
            _repository.CreateRentalMethod(rentalMethod);
            _repository.SaveChanges();
            return Ok(rentalMethod);
        }
        [HttpDelete("{id}")]
        [SwaggerOperation("DeleteRentalMethod")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult<RentalMethod>> DeleteRentalMethod(int id)
        {
            var rentalMethod = await _repository.GetRentalMethodById(id);
            if(rentalMethod == null)
            {
                return NotFound();
            }
            _repository.DeleteRentalMethod(rentalMethod);
            _repository.SaveChanges();
            return Ok(rentalMethod);
        }
        [HttpPut("{id}")]
        [SwaggerOperation("UpdateRentalMethod")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public ActionResult UpdateRentalMethod(int id, RentalMethodUpdateDto rentalMethod )
        {
            var rentalMethodModel = _repository.GetRentalMethodById(id);
            if(rentalMethodModel == null)
            {
                return NotFound();
            }
            _mapper.Map(rentalMethod, rentalMethodModel);
            _repository.SaveChanges();
            return NoContent();
        }
    }
}
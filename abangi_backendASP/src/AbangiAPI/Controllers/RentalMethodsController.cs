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
namespace AbangiAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
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
        public async Task<ActionResult<IEnumerable<RentalMethod>>> GetAll()
        {
            var rentalMethods = await _repository.GetAllRentalMethods();
            return Ok(rentalMethods);
        }

        [HttpPost]
        public ActionResult<RentalMethod> CreateRentalMethod(RentalMethod rentalMethod)
        {
            _repository.CreateRentalMethod(rentalMethod);
            _repository.SaveChanges();
            return Ok(rentalMethod);
        }
        [HttpDelete("{id}")]
        public ActionResult<RentalMethod> DeleteRentalMethod(int id)
        {
            var rentalMethod = _repository.GetRentalMethodById(id);
            if(rentalMethod == null)
            {
                return NotFound();
            }
            _repository.DeleteRentalMethod(rentalMethod);
            _repository.SaveChanges();
            return Ok(rentalMethod);
        }
        [HttpPut("{id}")]
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
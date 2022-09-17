using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace AbangiAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RentalMethodsController : ControllerBase
    {
        private readonly IRentalMethodAPIRepo _repository;
        public RentalMethodsController(IRentalMethodAPIRepo repository)
        {
            _repository = repository;
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
    }
}
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace AbangiAPI.Controllers
{
    
    [Route("api/[controller]")]
    [ApiController]
    public class ItemsController : ControllerBase
    {
        private readonly IItemAPIRepo _repository;
        public ItemsController(IItemAPIRepo repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Item>> GetAll()
        {
            var items = _repository.GetAllItems();
            return Ok(items);
        }
        [HttpGet("{id}")]
        public ActionResult<Item> GetItemById(int id)
        {
            var item = _repository.GetItemById(id);
            if(item == null)
            {
                return NotFound();
            }
            return Ok(item);
        }
    }
}
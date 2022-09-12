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
    public class ItemCategoriesController : ControllerBase
    {
        private readonly IItemCategoryAPIRepo _repository;
        public ItemCategoriesController(IItemCategoryAPIRepo repository)
        {
            _repository = repository;
        }
        [HttpGet]
        public ActionResult<IEnumerable<ItemCategory>> GetAll()
        {
            var itemCategories = _repository.GetAllItemCategories();
            return Ok(itemCategories);
        }
        [HttpGet("{id}")]
        public ActionResult<ItemCategory> GetItemCategoryById(int id)
        {
            var itemCategory = _repository.GetItemCategoryById(id);
            if (itemCategory == null)
            {
                return NotFound();
            }
            return Ok(itemCategory);
        }
    }
}
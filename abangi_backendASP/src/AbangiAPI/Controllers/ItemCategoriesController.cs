using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Dtos;
using AbangiAPI.Models;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;

namespace AbangiAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemCategoriesController : ControllerBase
    {
        private readonly IItemCategoryAPIRepo _repository;
        private readonly IMapper _mapper;
        public ItemCategoriesController(IItemCategoryAPIRepo repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ItemCategory>>> GetAll()
        {
            var itemCategories = await _repository.GetAllItemCategories();
            return Ok(itemCategories);
        }
        [HttpGet("{id}")]
        public async Task<ActionResult<ItemCategory>> GetItemCategoryById(int id)
        {
            var itemCategory = await _repository.GetItemCategoryById(id);
            if (itemCategory == null)
            {
                return NotFound();
            }
            return Ok(itemCategory);
        }
        [HttpGet("GetItemByCategory/{name}")]
        public async Task<ActionResult<IEnumerable<ItemInformation>>> GetItemByCategory(string name)
        {
            var item = await _repository.GetItemByCategory(name);
            if (item == null)
            {
                return NotFound();
            }
            return Ok(item);   
        }
    }
}
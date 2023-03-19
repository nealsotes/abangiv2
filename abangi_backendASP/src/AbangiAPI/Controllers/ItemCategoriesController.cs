using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Dtos;
using AbangiAPI.Models;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;
using System.Net;




namespace AbangiAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiExplorerSettings(IgnoreApi=true)]
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
        [SwaggerOperation("GetAllItemCategories")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult<IEnumerable<ItemCategory>>> GetAll()
        {
            var itemCategories = await _repository.GetAllItemCategories();
            return Ok(itemCategories);
        }
        [HttpGet("{id}")]
        [SwaggerOperation("GetItemCategoryById")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]

        public async Task<ActionResult<ItemCategory>> GetItemCategoryById(int id)
        {
            var itemCategory = await _repository.GetItemCategoryById(id);
            if (itemCategory == null)
            {
                return NotFound();
            }
            return Ok(itemCategory);
        }
        [HttpGet("GetItemByCategory/{name}/{id}")]
        [SwaggerOperation("GetItemByCategory")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        public async Task<ActionResult<IEnumerable<ItemInformation>>> GetItemByCategory(string name,int id)
        {
            var item = await _repository.GetItemByCategory(name, id);
            if (item == null)
            {
                return NotFound();
            }
            return Ok(item);   
        }
    }
}
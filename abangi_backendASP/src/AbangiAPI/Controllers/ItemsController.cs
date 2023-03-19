using System.IO;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Dtos;
using AbangiAPI.Models;
using AutoMapper;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Authorization;
using AbangiAPI.Helpers;
using System.Net;
using Swashbuckle.AspNetCore.Annotations;


namespace AbangiAPI.Controllers
{
    
    [Route("api/[controller]")]
    [ApiExplorerSettings(IgnoreApi=true)]
    [ApiController]
    public class ItemsController : ControllerBase
    {
        private readonly IWebHostEnvironment _env;
        private readonly DataContext _context;
        private readonly IItemAPIRepo _repository;
        private readonly IMapper _mapper;
        public ItemsController(IItemAPIRepo repository, IMapper mapper, IWebHostEnvironment env, DataContext context)
        {
            _repository = repository;
            _mapper = mapper;
            _env = env;
            
        
        }

        [HttpGet]
        [SwaggerOperation("GetAllItems")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        
        public async Task<ActionResult<IEnumerable<ItemInformation>>> GetAll()
        {
            var items =  await _repository.GetAllItems();
            
            return Ok(items);
           
           
        }
        [HttpGet("{id}", Name = "GetItemByUser"), Route("GetItemByUser/{id}")]
        [SwaggerOperation("GetItemByUser")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult<IEnumerable<ItemInformation>>> GetAllByUser(int id)
        {
            var items =  await _repository.GetAllItemsByUser(id);
            
            return Ok(items);
                
        }       


        [HttpGet("{id}", Name = "GetItemById")]
        [SwaggerOperation("GetItemById")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult<ItemInformation>> GetItemById(int id)
        {
            var item = await _repository.GetItemById(id);
            if(item == null)
            {
                return NotFound();
            }
            return Ok(item);
        }
        [AllowAnonymous]
        [HttpPost]
        [SwaggerOperation("CreateItem")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.BadRequest)]
        public  ActionResult<ItemReadDto> CreateItem([FromBody]ItemCreateDto itemCreateDto)
        
        {
               //validate if itemName already exists
              
          try
          {
            if(itemCreateDto.Image != null)
                {
                    _repository.SavePostImageAsync(itemCreateDto);
                }
                //validate duplicate item
                
                  var itemModel = _mapper.Map<Item>(itemCreateDto);


                
                _repository.CreateItem(itemModel);
                _repository.SaveChanges();
                var itemReadDto = _mapper.Map<ItemReadDto>(itemModel);
                return CreatedAtRoute(nameof(GetItemById), new { id = itemReadDto.ItemId }, itemReadDto);
          }catch(AppException ex)
          {
                return BadRequest(new { message = ex.Message });
          }
    
        }

        [HttpPut("{id}")]
        [SwaggerOperation("UpdateItem")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.BadRequest)]
        public ActionResult UpdateItem(int id, ItemUpdateDto itemUpdateDto)
        {
            var itemModelFromRepo = _repository.GetItemById(id);
            if(itemModelFromRepo == null)
            {
                return NotFound();
            }
            _mapper.Map(itemUpdateDto, itemModelFromRepo);
           // _repository.UpdateItem(itemModelFromRepo);
            _repository.SaveChanges();
            return NoContent();
        }
      
        [HttpDelete("{id}")]
        [SwaggerOperation("DeleteItem")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.BadRequest)]

        public ActionResult DeleteItem(int id)
        {   
            var itemModelFromRepo = _repository.GetItemById2(id);
            if(itemModelFromRepo == null)
            {
                return NotFound();
            }
            _repository.DeleteItem(itemModelFromRepo);
            _repository.SaveChanges();
            return NoContent();
        }
        [HttpGet("{id}", Name = "GetUserItemListings"), Route("GetUserItemListings/{id}")]
        [SwaggerOperation("GetUserItemListings")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]

        public async Task<ActionResult<IEnumerable<ItemInformation>>> GetUserItemListings(int id,string rentalStatus="")
        {
            var items =  await _repository.GetUserItemListings(id,rentalStatus);
            
            return Ok(items);
                
        }
    }
}
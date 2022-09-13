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
    public class ItemsController : ControllerBase
    {
        private readonly IItemAPIRepo _repository;
        private readonly IMapper _mapper;
        public ItemsController(IItemAPIRepo repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        
        }

        [HttpGet]
        public   ActionResult<IEnumerable<ItemReadDto>> GetAll()
        {
            var items = _repository.GetAllItems();
            
            return Ok(_mapper.Map<IEnumerable<ItemReadDto>>(items));
        }
        [HttpGet("{id}", Name="GetItemById")]
        public ActionResult<ItemReadDto> GetItemById(int id)
        {
            var item = _repository.GetItemById(id);
            if(item == null)
            {
                return NotFound();
            }
            return Ok(_mapper.Map<ItemReadDto>(item));
        }
        [HttpPost]
        public ActionResult<ItemReadDto> CreateItem(ItemCreateDto itemCreateDto)
        {
            var itemModel = _mapper.Map<Item>(itemCreateDto);
            _repository.CreateItem(itemModel);
            _repository.SaveChanges();
            var itemReadDto = _mapper.Map<ItemReadDto>(itemModel);
            return CreatedAtRoute(nameof(GetItemById), new { id = itemReadDto.ItemId }, itemReadDto);
        }

        [HttpPut("{id}")]
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
        [HttpPatch("{id}")]
        public ActionResult PartialItemUpdate(int id, JsonPatchDocument<ItemUpdateDto> patchDocument)
        {
            var itemModelFromRepo = _repository.GetItemById(id);
            if(itemModelFromRepo == null)
            {
                return NotFound();
            }
            var itemToPatch = _mapper.Map<ItemUpdateDto>(itemModelFromRepo);
            patchDocument.ApplyTo(itemToPatch, ModelState);
            if(!TryValidateModel(itemToPatch))
            {
                return ValidationProblem(ModelState);
            }
            _mapper.Map(itemToPatch, itemModelFromRepo);
            _repository.UpdateItem(itemModelFromRepo);
            _repository.SaveChanges();
            return NoContent();
        }
        [HttpDelete("{id}")]
        public ActionResult DeleteItem(int id)
        {   
            var itemModelFromRepo = _repository.GetItemById(id);
            if(itemModelFromRepo == null)
            {
                return NotFound();
            }
            _repository.DeleteItem(itemModelFromRepo);
            _repository.SaveChanges();
            return NoContent();
        }
    }
}
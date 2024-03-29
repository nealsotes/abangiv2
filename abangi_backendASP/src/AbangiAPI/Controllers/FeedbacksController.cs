using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace AbangiAPI.Controllers
{
    [ApiController]
    [ApiExplorerSettings(IgnoreApi=true)]
    [Route("api/[controller]")]
    public class FeedbacksController : ControllerBase
    {
            private readonly IFeedbackAPIRepos _repository;
            
            public FeedbacksController(IFeedbackAPIRepos repository)
            {
                _repository = repository;
            }
            [HttpGet("{id}", Name = "GetFeedbackById")]
            [SwaggerOperation("GetFeedback")]
            [SwaggerResponse((int)HttpStatusCode.OK)]
            [SwaggerResponse((int)HttpStatusCode.NotFound)]

            public async Task<ActionResult<FeedbackInformation>> GetFeedbackById(int id)
            {
                var feedback = await _repository.GetFeedbackById(id);
                if(feedback == null)
                {
                    return NotFound();
                }
                return Ok(feedback);
            }

            [HttpPost]
            [SwaggerOperation("CreateFeedback")]
            [SwaggerResponse((int)HttpStatusCode.OK)]
            [SwaggerResponse((int)HttpStatusCode.BadRequest)]
            public  ActionResult<Feedback> CreateFeedback(Feedback feedback)
            {
                 _repository.CreateFeedback(feedback);
                _repository.SaveChanges();
                return Ok(feedback);
                
            }
            //get feedback by item id
            [HttpGet("item/{id}")]
            [SwaggerOperation("GetFeedbackByItemId")]
            [SwaggerResponse((int)HttpStatusCode.OK)]
            [SwaggerResponse((int)HttpStatusCode.NotFound)]
            public async Task<ActionResult<IEnumerable<FeedbackInformation>>> GetFeedbackByItemId(int id)
            {
                var feedback = await _repository.GetFeedbackByItemId(id);
                if(feedback == null)
                {
                    return NotFound();
                }
                return Ok(feedback);
            }

    }
}
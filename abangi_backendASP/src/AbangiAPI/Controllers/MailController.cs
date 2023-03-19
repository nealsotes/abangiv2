using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;
using System.Net;

namespace AbangiAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [ApiExplorerSettings(IgnoreApi=true)]
    public class MailController : ControllerBase
    {
        private readonly IMailService _mailService;
        public MailController (IMailService mailService)
        {
            _mailService = mailService;
        }
        [HttpPost("send")]
        [SwaggerOperation("SendEmail")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> SendEmail([FromForm] MailRequest mailRequest)
        {
           try
           {
                await _mailService.SendEmailAsync(mailRequest);
                return Ok();
              }
              catch (Exception e)
              {
                return BadRequest(e.Message);
           }
        }
    }
}
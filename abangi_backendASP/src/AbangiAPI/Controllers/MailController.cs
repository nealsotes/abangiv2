using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace AbangiAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MailController : ControllerBase
    {
        private readonly IMailService _mailService;
        public MailController (IMailService mailService)
        {
            _mailService = mailService;
        }
        [HttpPost("send")]
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
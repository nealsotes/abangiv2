using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models.ChatApp;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChatsController : ControllerBase
    {
        public readonly DataContext _context;
        public ChatsController(DataContext context)
        {
            _context = context;
        }

        [HttpPost("{id}")]
        public async Task<IActionResult> CreateMessage(int id, [FromBody] Message message)
        {
            var user = await (from u in _context.Users
                              where u.UserId == id
                              select u.FullName).FirstOrDefaultAsync();
            message.FullName = user;
            message.UserId = id;
            await _context.Messages.AddAsync(message);
            await _context.SaveChangesAsync();
            return Ok(message);
        }
        [HttpGet]
        public async Task<IActionResult> GetAllMessages()
        {
            var messages = await _context.Messages.ToListAsync();
            return Ok(messages);
        }

    }
}
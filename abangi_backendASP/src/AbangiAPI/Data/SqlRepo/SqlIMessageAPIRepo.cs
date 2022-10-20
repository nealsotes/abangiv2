using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models.ChatApp;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlIMessageAPIRepo : IMessageAPIRepo
    {
        private readonly DataContext _context;
        public async Task CreateMessage(Message message)
        {
          
           await _context.Messages.AddAsync(message);
        }

        public Task<IEnumerable<Message>> GetAllMessages()
        {
            throw new NotImplementedException();
        }

        public async Task<Message> GetMessageById(int id)
        {
            return await _context.Messages.FirstOrDefaultAsync(p => p.Id == id);
        }

        public void SaveChanges()
        {
            throw new NotImplementedException();
        }
    }
}
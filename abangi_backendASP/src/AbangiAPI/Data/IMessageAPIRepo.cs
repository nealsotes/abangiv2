using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models.ChatApp;

namespace AbangiAPI.Data
{
    public interface IMessageAPIRepo
    {
        Task CreateMessage(Message message);
        Task<IEnumerable<Message>> GetAllMessages();
        Task<Message> GetMessageById(int id);
        void SaveChanges();
    }
}
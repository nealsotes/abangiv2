using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.AspNetCore.SignalR;

namespace AbangiAPI.Hubs
{
    public class ChatHub : Hub
    {
          private readonly DataContext _context;

        public ChatHub(DataContext context)
        {
            _context = context;
        }
        public async Task SendMessage(string user, string message)
        {
            var msg = new Message
            {
                //save user and message to database,
                User = user,
                Text = message,
                Timestamp = DateTime.Now
                
            };
            _context.Messages.Add(msg);
            _context.SaveChanges();

            await Clients.All.SendAsync("ReceiveMessage", user, message);
            }
        
       
    }
}
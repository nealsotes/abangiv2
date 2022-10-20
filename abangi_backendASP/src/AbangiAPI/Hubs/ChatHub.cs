using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models.ChatApp;
using Microsoft.AspNetCore.SignalR;

namespace AbangiAPI.Hubs
{
    public class ChatHub : Hub
    {
        public async Task SendMessage(Message message )
        {
            await Clients.All.SendAsync("ReceiveMessage", message);
            
        }
    }
}
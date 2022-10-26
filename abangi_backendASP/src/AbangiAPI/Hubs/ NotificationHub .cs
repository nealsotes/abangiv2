using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Dtos;
using AbangiAPI.Helpers;
using Microsoft.AspNetCore.SignalR;

namespace AbangiAPI.Hubs
{
    public class  NotificationHub : Hub<INotificationClient>
    {
        private static readonly Dictionary<String, UserModel> Users = new Dictionary<String, UserModel>();
        private readonly DataContext _context;
        public  NotificationHub (DataContext context)
        {
            _context = context;
        }
        public override Task OnConnectedAsync()
        {
            UpdateUserList();
            return base.OnConnectedAsync();
        }
        public override Task OnDisconnectedAsync(Exception exception)
        {
            UpdateUserList();
            return base.OnDisconnectedAsync(exception);
        }
        public async Task SendMessage(string name, string message)
        {
            await Clients.All.ReceiveMessage($"{name}: {message}");
        }

        private Task UpdateUserList()
        {
            var usersList = _context.Users.Select(u => new UserModel
            {
                UserId = u.UserId,
                FullName = u.FullName,
                Status = "Offline",
            }).ToList();
            foreach(var user in usersList)
            {
                if(Users.Values.Any(u => u.UserId == user.UserId))
                {
                    user.Status = "Online";
                }
               
            }



            return Clients.All.UpdatedUserList(Users);
        }
    }
}
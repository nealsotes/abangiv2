using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace AbangiAPI.Hubs
{
    public class UserVerifyNotification : Hub<IUserVerifyNotification>
    {
        public async Task SendMessageVerify(string user, string message)
        {
            await Clients.All.SendMessageVerify(user, message);
        }
    }
}
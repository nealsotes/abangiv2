using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Hubs
{
    public interface INotificationClient
    {
        Task MessageToUser(Object outgoingMessage);
        Task UpdatedUserList(Object onlineUsers);
        Task ReceiveMessage(string message);
    }
}
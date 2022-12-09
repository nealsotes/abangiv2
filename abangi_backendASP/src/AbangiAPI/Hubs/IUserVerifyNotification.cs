using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Hubs
{
    public interface IUserVerifyNotification
    {
        Task SendMessageVerify(string user, string message);
    }
}
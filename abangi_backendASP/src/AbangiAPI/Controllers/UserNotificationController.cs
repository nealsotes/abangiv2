using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Hubs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using System.Net;
using Swashbuckle.AspNetCore.Annotations;

namespace AbangiAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [ApiExplorerSettings(IgnoreApi=true)]
    public class UserNotificationController : ControllerBase
    {
        private IHubContext<UserVerifyNotification,IUserVerifyNotification> _hubContext;
        public UserNotificationController(IHubContext<UserVerifyNotification,IUserVerifyNotification> hubContext)
        {
            _hubContext = hubContext;
        }
        [HttpPost]
        [Route("SendVerifyMessage")]
        [SwaggerOperation("SendVerifyMessage")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.BadRequest)]

        //Send notification to user
        public string Get()
        {
            List<string> notif = new List<string>();
            notif.Add("User1");
            notif.Add("User2");
            notif.Add("User3");
            _hubContext.Clients.All.SendMessageVerify("User1", "Message");
            return "Message sent";
        }
    }
}
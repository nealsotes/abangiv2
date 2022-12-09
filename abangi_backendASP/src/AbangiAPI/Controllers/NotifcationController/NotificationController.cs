using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data.NotificationServices;
using AbangiAPI.Models.Notification;
using Microsoft.AspNetCore.Mvc;

namespace AbangiAPI.Controllers.NotifcationController
{
    [ApiController]
    [Route("api/[controller]")]
    public class NotificationController : ControllerBase
    {
        private readonly INotificationService _notificationService;
        public NotificationController(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }
        [Route("send")]
        [HttpPost]
        public async Task<IActionResult> SendNotification([FromBody] NotificationModel notificationModel)
        {
            var response = await _notificationService.SendNotification(notificationModel);
            return Ok(response);
        }
     
    }
}
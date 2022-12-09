using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace AbangiAPI.Models.Notification
{
    public class NotificationModel
    {
        [JsonProperty("deviceId")]
        public string DeviceId { get; set; }
        [JsonProperty("isAndroidDevice")]
        public bool IsAndroidDevice { get; set; }
        [JsonProperty("title")]
        public string Title { get; set; }
        [JsonProperty("body")]
        public string Body { get; set; }

    }
    public class GoogleNotification 
    {
        public class DataPayload
        {
            [JsonProperty("title")]
            public string Title { get; set; }
            [JsonProperty("body")]
            public string Body { get; set; }
        }
        //set priority to high to show alert notification
        [JsonProperty("priority")]
        public string Priority { get; set; } = "high";

        public DataPayload Data { get; set; }
      
        [JsonProperty("notification")]
        public DataPayload Notification { get; set; }
    }

}
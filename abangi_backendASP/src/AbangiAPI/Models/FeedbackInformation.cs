using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models
{
    public class FeedbackInformation
    {
        public int FeedbackId {get; set;}
        public string FullName {get; set;}

        public string UserImage {get; set;}
        public string Ratings {get; set;}
        public string Comments {get; set;}
        public DateTime Date_Rated {get; set;}
        public int ItemId {get; set;}
    }
}
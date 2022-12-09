using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Entities;

namespace AbangiAPI.Models
{
    public class Feedback
    {
        public int FeedbackId {get; set;}
        public int UserId {get; set;}
        public User User {get; set;}
        public int ItemId {get; set;}
        public Item Item {get; set;}
        public string Ratings {get; set;}
        public string Comments {get; set;}
        public DateTime Date_Rated {get; set;}
        public Feedback()
        {
            Date_Rated = DateTime.Now;
        }
    }
}
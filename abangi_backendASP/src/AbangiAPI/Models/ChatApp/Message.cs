using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Entities;

namespace AbangiAPI.Models.ChatApp
{
    public class Message
    {
        [Key]
        public int Id  { get; set; }
        public string FullName{ get; set; }
        public string Text { get; set; }
        public DateTime Timestamp { get; set; }
        public int UserId { get; set; }
        public virtual User User { get; set; }
    }
}
using System.ComponentModel.DataAnnotations.Schema;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Entities;

namespace AbangiAPI.Models
{
    public class Message
    {
        [Key]
        public int Id { get; set; }
        public string User { get; set; }
      
        public string Text { get; set; }
        public DateTime Timestamp { get; set; }
    }
}
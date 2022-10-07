using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Dtos
{
    public class ItemReadDto
    {   
        
        public int ItemId { get; set; }
        public string ItemName { get; set; }
        public string ItemDescription { get; set; }
        public string ItemImage { get; set; }
        public int ItemCategoryId { get; set; }
        public int UserId { get; set; }
        public int rentalMethodId { get; set; }
        public string ItemLocation { get; set; }
       
        public DateTime DateCreated {get; set;}
        public DateTime StartDate {get; set;}
        public DateTime EndDate {get; set;}
        
        
    }
}
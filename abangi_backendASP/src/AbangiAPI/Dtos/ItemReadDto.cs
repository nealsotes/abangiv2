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
        public ItemCategory ItemCategoryName{ get; set; }
         public string ItemImage { get; set; }
        public string ItemName { get; set; }
        public string ItemDescription { get; set; }
    }
}
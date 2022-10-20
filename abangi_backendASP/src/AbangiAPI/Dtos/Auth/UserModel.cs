using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Dtos
{
    public class UserModel
    {
        public int UserId {get; set;}
        public string FullName { get; set; }
        public string Email {get; set;}
        public string Contact {get; set;}
        public string Address {get; set;} 

        public string UserImage {get; set;}
        public string UserGovertId {get; set;}
        //public string Password {get; set;}
        public string Role {get; set;}
        public String IsAbangiVerified {get; set;}
        public String Status {get; set;}
        public ICollection<Item> Items {get; set;}
    }
}
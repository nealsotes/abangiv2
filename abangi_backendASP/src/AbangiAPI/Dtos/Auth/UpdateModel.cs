
using Microsoft.AspNetCore.Http;

namespace AbangiAPI.Dtos
{
    public class UpdateModel
    {
       
        public string FullName { get; set; }
        public string Email {get; set;}
        public string Phone {get; set;}
        public string Address {get; set;} 
        public string Password {get; set;}

        public IFormFile UserImageFile {get; set;}
        public string UserImage {get; set;}

        public IFormFile UserGovernmentIdFile {get; set;}
        public string UserGovertId {get; set;}
    }
}
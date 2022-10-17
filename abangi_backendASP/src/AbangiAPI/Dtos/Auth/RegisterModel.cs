using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;

namespace AbangiAPI.Dtos
{
    public class RegisterModel
    {
        public int UserId { get; set; }
        [Required]
        public string FullName { get; set; }
        [Required]
        public string Email {get; set;}
         [Required]
        public string Contact {get; set;}
        [Required]
        public string Address {get; set;}

        public IFormFile UserImageFile {get; set;}
        public string UserImage {get; set;}
        public string UserGovertId {get; set;}
        public IFormFile UserGovernmentIdFile {get; set;}
        
        [Required]
        public string Password {get; set;}

    }
}
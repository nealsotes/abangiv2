using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;

namespace AbangiAPI.Dtos
{
    public class RegisterModel
    {
        public int UserId { get; set; }
        [Required(ErrorMessage = "Name is required")]
        public string FullName { get; set; }
        [Required]
        [EmailAddress(ErrorMessage = "Invalid Email Address")]
        
        public string Email {get; set;}
        [Required(ErrorMessage = "Contact is required")]
        public string Contact {get; set;}
        [Required(ErrorMessage = "Address is Required")]
        public string Address {get; set;}
        
        public IFormFile UserImageFile {get; set;}
        
        public string UserImage {get; set;}

        public string DeviceId {get; set;}
        
        public string UserGovertId {get; set;}
        public string Status  {get; set;}
        public IFormFile UserGovernmentIdFile {get; set;}
        
        [Required(ErrorMessage = "Password is required")]
        [StringLength(255, MinimumLength = 5, ErrorMessage = "Password must be at least 5 characters long")]
        [DataType(DataType.Password)]
        public string Password {get; set;}
        public bool isMailConfirmed { get; set; }
        public RegisterModel()
        {
            isMailConfirmed = false;
        }

    }
} 
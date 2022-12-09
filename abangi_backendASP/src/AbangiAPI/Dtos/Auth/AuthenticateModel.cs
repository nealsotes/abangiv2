using System.ComponentModel.DataAnnotations;

namespace AbangiAPI.Dtos
{
    public class AuthenticateModel
    {
        [Required]
        public string Email {get; set;}

        [Required]
        public string Password{get; set;}

        
    }
}
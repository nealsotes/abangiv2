using System.ComponentModel.DataAnnotations;


namespace AbangiAPI.Dtos
{
    public class RegisterModel
    {
        [Required]
        public string Name { get; set; }
        [Required]
        public string Email {get; set;}
        [Required]
        public string Phone {get; set;}
        [Required]
        public string Address {get; set;}
        [Required]
        public string Password {get; set;}

    }
}
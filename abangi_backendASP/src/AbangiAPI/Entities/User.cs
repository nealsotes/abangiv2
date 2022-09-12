using System.ComponentModel.DataAnnotations;

namespace AbangiAPI.Entities
{
    public class User
    {
        [Key]
        [Required]
        public int UserId { get; set; }
        [Required]
        [MinLength(2),MaxLength(150)]
        public string FullName { get; set; }
        public string UserImage {get; set;}
        [Required]
        public string Email { get; set; }
        [Required]
        public string Address { get; set; }
        [Required]
        public string Contact { get; set; }
       
        public byte[] PasswordHash { get; set; }
        public byte[] PasswordSalt { get; set; }
    }
}
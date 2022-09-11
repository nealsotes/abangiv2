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
        public string Name { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public string Phone { get; set; }
        [Required]
        public string Address { get; set; }
        public byte[] PasswordHash { get; set; }
        public byte[] PasswordSalt { get; set; }
    }
}
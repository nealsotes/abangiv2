using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

using AbangiAPI.Models;

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
        public string Status { get; set; }
        public string UserGovertId  {get; set;}
        public byte[] PasswordHash { get; set; }
        public byte[] PasswordSalt { get; set; }
        public virtual ICollection<Item> Items { get; set; }
        public virtual ICollection<UserRole> UserRoles { get; set; }
        public virtual ICollection<Feedback> Feedbacks { get; set; }

         public string DeviceId {get; set;}
        public bool isMailConfirmed { get; set; }
        public string  EmailConfirmationToken { get; set; }
  
      
        public DateTime EmailConfirmationTokenExpiryDate {get; set;}
        public User()
        {
           EmailConfirmationToken = System.Guid.NewGuid().ToString();
           EmailConfirmationTokenExpiryDate = DateTime.Now.AddMinutes(30);
          

        }
    }
}
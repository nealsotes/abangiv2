using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Entities;

namespace AbangiAPI.Models
{
    public class UserRole
    {
        [Key]
        [Required]
        public int UserRoleId { get; set; }
        [Required]
        public int UserId { get; set; }
        [Required]
        public int RoleId { get; set; }
        [DataType(DataType.Date)]
        public DateTime DateCreated { get; set; }
        public bool IsActive { get; set; }
        public bool AbangiVerified { get; set; }
        public UserRole()
        {
            DateCreated = DateTime.Now;
        }
        
    }
}
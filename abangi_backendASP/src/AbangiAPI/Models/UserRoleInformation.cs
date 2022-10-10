using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models
{
    public class UserRoleInformation
    {
        public int UserRoleId {get; set;}
        [Column("User")]
        public string User {get; set;}
        [Column("Role")]
        public string Role {get; set;}
        public DateTime DateCreated {get; set;}
        public bool IsActive {get; set;}
        [Column("AbangiVerified")]
        public bool AbangiVerified {get; set;}
    }
}
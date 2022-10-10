using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IRoleAPIRepo
    {
        bool SaveChanges();
        Task<IEnumerable<Role>> GetAllRoles();  
        Role GetRolesById(int id);
        void CreateRole(Role role);
        void UpdateRole(Role role);
        void DeleteRole(Role role);
        
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IUserRoleAPIRepo
    {
        bool SaveChanges();
        Task<IEnumerable<UserRoleInformation>> GetAllUserRoles();
        Task<UserRole> GetUserRoleById(int id);
        void CreateUserRole(UserRole userRole);
        void UpdateUserRole(UserRole userRole);
        void DeleteUserRole(UserRole userRole);
        
    }
}
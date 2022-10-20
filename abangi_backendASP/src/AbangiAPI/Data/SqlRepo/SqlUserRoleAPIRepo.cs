using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlUserRoleAPIRepo : IUserRoleAPIRepo
    {
        private readonly DataContext _context;
        public SqlUserRoleAPIRepo(DataContext context)
        {
            _context = context;
        }

        public void CreateUserRole(UserRole userRole)
        {
            if(userRole == null)
            {
                throw new ArgumentNullException(nameof(userRole));
            }
            _context.Add(userRole);
        }

        public void DeleteUserRole(UserRole userRole)
        {
            if(userRole == null)
            {
                throw new ArgumentNullException(nameof(userRole));
            }
            _context.UserRoles.Remove(userRole);
        }

        public async Task<IEnumerable<UserRoleInformation>> GetAllUserRoles()
        {
            var userRoleList = from i in _context.UserRoles
                                join u in _context.Users on i.UserId equals u.UserId
                                join r in _context.Roles on i.RoleId equals r.RoleId
                               select new UserRoleInformation
                               {
                                    UserRoleId = i.UserRoleId,
                                    User = u.FullName,
                                    Role = r.RoleName,
                                    DateCreated = i.DateCreated,
                                    IsActive = i.IsActive,
                                    AbangiVerified = i.AbangiVerified                                    
                               };
                            

            return await userRoleList.ToListAsync();
        }

        public async Task<UserRole> GetUserRoleById(int id)
        {
            return await _context.UserRoles.FirstOrDefaultAsync(p => p.UserRoleId == id);
        }

        public bool SaveChanges()
        {
            return (_context.SaveChanges() >= 0);
        }

        public void UpdateUserRole(UserRole userRole)
        {
            throw new NotImplementedException();
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlRoleAPIRepo : IRoleAPIRepo
    {
        private readonly DataContext _context;

        public SqlRoleAPIRepo(DataContext context)
        {   
            _context = context;
        }
        public void CreateRole(Role role)
        {
           if(role == null)
           {
               throw new ArgumentNullException(nameof(role));
           }
           _context.Add(role);
        }

        public void DeleteRole(Role role)
        {
            if(role == null)
            {
                throw new ArgumentNullException(nameof(role));
            }
            _context.Roles.Remove(role);
        }

       public async Task<IEnumerable<Role>> GetAllRoles()
        {
           return await _context.Roles.ToListAsync();
        }

        public Role GetRolesById(int id)
        {
            return _context.Roles.FirstOrDefault(p => p.RoleId == id);
        }

        public bool SaveChanges()
        {
            return (_context.SaveChanges() >= 0);
        }

        public void UpdateRole(Role role)
        {
            throw new NotImplementedException();
        }
    }
}
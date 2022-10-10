using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace AbangiAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserRolesController : Controller
    {
        private readonly IUserRoleAPIRepo _repository;
        public UserRolesController(IUserRoleAPIRepo repository)
        {
            _repository = repository;
        }
        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserRole>>> GetAllUserRoles()
        {
            var userRoles = await _repository.GetAllUserRoles();
            return Ok(userRoles);
        }
        [HttpPost]
        public ActionResult<UserRole> CreateUserRoles(UserRole userRole)
        {
            _repository.CreateUserRole(userRole);
            _repository.SaveChanges();
            return Ok(userRole);
        }
        [HttpGet("{id}")]
        public ActionResult<UserRole> GetUserRoleById(int id)
        {
            var userRole = _repository.GetUserRoleById(id);
            if(userRole == null)
            {
                return NotFound();
            }
            return Ok(userRole);
        }
        [HttpDelete("{id}")]
        public ActionResult DeleteUserRole(int id)
        {
            var userRoleFromRepo = _repository.GetUserRoleById(id);
            if(userRoleFromRepo == null)
            {
                return NotFound();
            }
            _repository.DeleteUserRole(userRoleFromRepo);
            _repository.SaveChanges();
            return NoContent();
        }
    }
}
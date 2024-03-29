using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Swashbuckle.AspNetCore.Annotations;
using System.Net;

namespace AbangiAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [ApiExplorerSettings(IgnoreApi=true)]
    public class UserRolesController : Controller
    {
        private readonly IUserRoleAPIRepo _repository;
        public UserRolesController(IUserRoleAPIRepo repository)
        {
            _repository = repository;
        }
        [HttpGet]
        [SwaggerOperation("GetAllUserRoles")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult<IEnumerable<UserRole>>> GetAllUserRoles()
        {
            var userRoles = await _repository.GetAllUserRoles();
            return Ok(userRoles);
        }
        [HttpPost]
        [SwaggerOperation("CreateUserRole")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public ActionResult<UserRole> CreateUserRoles(UserRole userRole)
        {
            _repository.CreateUserRole(userRole);
            _repository.SaveChanges();
            return Ok(userRole);
        }
        [HttpGet("{id}")]
        [SwaggerOperation("GetUserRoleById")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
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
        [SwaggerOperation("DeleteUserRole")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult> DeleteUserRole(int id)
        {
            var userRoleFromRepo = await _repository.GetUserRoleById(id);
            if(userRoleFromRepo == null)
            {
                return NotFound();
            }
            _repository.DeleteUserRole(userRoleFromRepo);
            _repository.SaveChanges();
            return NoContent();
        }
        [HttpPut("{id}")]
        [SwaggerOperation("UpdateUserRole")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult> UpdateUserRole(int id, UserRole userRole)
        {
            var userRoleFromRepo = await _repository.GetUserRoleById(id);
            if(userRoleFromRepo == null)
            {
                return NotFound();
            }
            _repository.UpdateUserRole(userRoleFromRepo);
            _repository.SaveChanges();
            return NoContent();
        }
    }
}
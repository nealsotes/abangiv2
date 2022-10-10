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
    public class RolesController : Controller
    {
       
        private readonly IRoleAPIRepo _repository;
        public RolesController(IRoleAPIRepo repository)
        {
            _repository = repository;
           
        }
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Role>>> GetAllRole()
        {
            var roles = await _repository.GetAllRoles();
            return Ok(roles);
        }
        [HttpPost]
        public ActionResult<Role> CreateRole(Role role)
        {
            _repository.CreateRole(role);
            _repository.SaveChanges();
            return Ok(role);
        }
        [HttpGet("{id}")]
        public ActionResult<Role> GetRoleById(int id)
        {
            var role = _repository.GetRolesById(id);
            if(role == null)
            {
                return NotFound();
            }
            return Ok(role);
        }
        [HttpPut("{id}")]
        public ActionResult UpdateRole(int id, Role role)
        {
            var roleFromRepo = _repository.GetRolesById(id);
            if(roleFromRepo == null)
            {
                return NotFound();
            }
            _repository.UpdateRole(roleFromRepo);
            _repository.SaveChanges();
            return NoContent();
        }
    }
}
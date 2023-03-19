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
    [ApiExplorerSettings(IgnoreApi=true)]
    [ApiController]
    public class RolesController : Controller
    {
       
        private readonly IRoleAPIRepo _repository;
        public RolesController(IRoleAPIRepo repository)
        {
            _repository = repository;
           
        }
        [HttpGet]
        [SwaggerOperation("GetAllRoles")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult<IEnumerable<Role>>> GetAllRole()
        {
            var roles = await _repository.GetAllRoles();
            return Ok(roles);
        }
        [HttpPost]
        [SwaggerOperation("CreateRole")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public ActionResult<Role> CreateRole(Role role)
        {
            _repository.CreateRole(role);
            _repository.SaveChanges();
            return Ok(role);
        }
        [HttpGet("{id}")]
        [SwaggerOperation("GetRoleById")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
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
        [SwaggerOperation("UpdateRole")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
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
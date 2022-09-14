using System.Linq;
using System;
using Microsoft.Extensions.Options;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Authorization;
using AutoMapper;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using AbangiAPI.Services;
using AbangiAPI.Entities;
using AbangiAPI.Helpers;
using AbangiAPI.Dtos;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;

namespace AbangiAPI.Controllers
{  
    //[Authorize]
    [ApiController]
    [Route("[controller]")]
    public class UsersController : ControllerBase
    {
        
        private readonly IUserAPIRepo _repository;
        private IMapper _mapper;
        private readonly AppSettings _appsettings;
        public UsersController(IUserAPIRepo repository, IMapper mapper, IOptions<AppSettings> appsettings)
        {
            _repository = repository;
            _mapper = mapper;
            _appsettings = appsettings.Value;
        
        }
        [AllowAnonymous]
        [HttpPost("login")]
        public  IActionResult Authenticate([FromBody]AuthenticateModel model)
        {
            
            var user = _repository.Authenticate(model.Email, model.Password);
            if(user == null)
            {
                return BadRequest(new {message = "Email or password is incorrect!"});
            }
          

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appsettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Email, user.UserId.ToString())

                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);

            //return basic user info and authentication token

            return Ok(new {
                Token = tokenString
            });
        }

        [AllowAnonymous]
        [HttpPost("register")]
        public IActionResult Register([FromBody] RegisterModel model)
        {
            //map model to entity
            var user = _mapper.Map<User>(model);

            try
            {
                //create user
                _repository.Create(user, model.Password);
                return Ok();
            }
            catch(AppException ex)
            {
                //return error message if there was an exception
                return BadRequest(new {message = ex.Message});
            }
        }

        [HttpGet("logout")]
        public async Task<IActionResult> Logout()
        {   
            await HttpContext.SignOutAsync();
            return Ok();
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var user = _repository.GetById(id);
            var model = _mapper.Map<UserModel>(user);
            return Ok(model);
        }
        [HttpPut("{id}")]
        public IActionResult Update(int id, [FromBody]UpdateModel model)
        {
            //map model to entity and set id
            var user = _mapper.Map<User>(model);
            user.UserId = id;
            
            try
            {   
                //update user
                _repository.Update(user, model.Password);
                return Ok();
            }
            catch(AppException ex)
            {
                //return error message if there was an exception
                return BadRequest(new {message = ex.Message});
            }
        }
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            _repository.Delete(id);
            return Ok();
        }

        [HttpGet]
        public ActionResult<IEnumerable<User>> GetAllUsers()
        {
            var users = _repository.GetAll();
            var model = _mapper.Map<IList<UserModel>>(users);
            return Ok(model);
        }

    }
}
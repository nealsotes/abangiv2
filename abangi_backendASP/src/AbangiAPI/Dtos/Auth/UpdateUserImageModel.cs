using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace AbangiAPI.Dtos.Auth
{
    public class UpdateUserImageModel
    {
        public IFormFile UserGovertIdFile { get; set; }
        public string UserGovertId { get; set; }
    }
}
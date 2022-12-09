using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IForgotPassword
    {
        //send password reset link to user
        public Task<ForgotPassword> SendPasswordResetLink(ForgotPassword forgotPassword);
    }
}
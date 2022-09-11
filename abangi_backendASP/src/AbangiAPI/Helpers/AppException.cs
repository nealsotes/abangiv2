using System.Globalization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Helpers
{
    public class AppException : Exception
    {
        public AppException() : base() { }
        
        public AppException(string message) : base(message) { }
        
        public AppException(String message,params object[] args) : base(String.Format(CultureInfo.CurrentCulture, message, args))
        {

        }
    }
}
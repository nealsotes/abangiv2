using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Helpers
{
    public class FileHelper
    {
        public static string GetUniqueFileName(string filename)
        {
            filename = Path.GetFileName(filename);
            return string.Concat(Path.GetFileNameWithoutExtension(filename), "_", Guid.NewGuid().ToString().Substring(0, 4), Path.GetExtension(filename));
        }
    }
}
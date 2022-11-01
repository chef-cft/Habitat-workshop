using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace dotnet_test.Pages
{
    public class IndexModel : PageModel
    {
        public string VersionMessage { get; set; }
        public string Message { get; set; }
        private readonly ILogger<IndexModel> _logger;

        public IndexModel(ILogger<IndexModel> logger, IConfiguration _configuration)
        {
            _logger = logger;
            VersionMessage = _configuration["Message"];
        }

        public void OnPostCreate() {
            if(!System.IO.File.Exists("myfile")) {
                System.IO.File.Create("myfile");
                Message = "Transaction Created!";
            } else {
                Message = "Transaction Already Created!";
            }
        }
        public void OnPostComplete() {
            if(System.IO.File.Exists("myfile")) {
                System.IO.File.Delete("myfile");
                Message = "Transaction Colmpleted!";
            } else {
                Message = "There are no transactions!";
            }
        }
    }
}

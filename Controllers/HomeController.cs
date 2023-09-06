using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace Facebook.Controllers
{
    /*The given code represents a C# ASP.NET Core controller named HomeController within a Facebook application. 
     * Here's a summary of what the code does: The HomeController constructor is injected with an 
     * ILogger<HomeController> dependency for logging purposes. The Index action returns a view for the home page.
     * It is the default action that is executed when the user visits the application's root URL.
     The Privacy action returns a view for the privacy policy page.
     In summary, the HomeController handles actions related to the home page and privacy policy page in the Facebook 
     application.*/
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

    }


}

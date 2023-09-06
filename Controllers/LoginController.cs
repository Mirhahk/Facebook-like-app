using Facebook.Common;
using Facebook.IRepository;
using Facebook.Models;
using Facebook.ViewModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text.Json.Serialization;
using System.Xml.Linq;

namespace Facebook.Controllers
{
    /*The given code represents a C# ASP.NET Core controller named LoginController within a Facebook application. 
     * Here's a summary of what the code does:
The LoginController constructor is injected with an ILogin dependency for user login and signup functionality.
The Index action handles GET requests and returns a view for the login page.

The Index action handles POST requests with the username/email and password parameters for user authentication. 
	It calls the GetUser method of the injected ILogin repository to validate the user's credentials. If the user 
	is found, it stores the user information in the session and returns a JSON response indicating a successful
	login. If the user is not found, it returns a JSON response indicating that the user was not found.

The Signup action handles POST requests with the username, password, and email parameters for user registration.
	It calls the CreateUser method of the injected ILogin repository to create a new user account. If the account
	creation is successful, it returns a JSON response indicating a successful account creation. If the account 
	creation fails, it returns a JSON response indicating that a different email or username should be used.

In summary, the LoginController handles actions related to user login and signup in the Facebook application.*/
    public class LoginController : Controller
	{
		private readonly ILogin _user;
		public LoginController(ILogin user)
		{
			_user = user;
		}

		[HttpGet]
		public IActionResult Index()
		{
			return View();
		}

		[HttpPost]
		public JsonResult Index(string username_email, string password)
		{

			Response res = new Response();
			try
			{
				View_userlogin userlogin = new View_userlogin();
				userlogin = _user.GetUser(username_email, password);
				if (userlogin != null)
				{
					HttpContext.Session.SetString("User", JsonConvert.SerializeObject(userlogin));
					res.data = userlogin;
					res.flag = true;
					res.status = 200;
					res.message = "OK";
				}
				else
				{
					res.data = null;
					res.flag = false;
					res.status = 200;
					res.message = "User Not Found";

				}
			}
			catch (Exception ex)
			{

				res.flag = false;
				res.status = 500;
				res.message = ex.Message;
			}

			return Json(new JsonResult(res));
		}

		[HttpPost]
		public JsonResult Signup(string username, string pass, string email)
		{
			Response res = new Response();
			try
			{
				var result = _user.CreateUser(username, pass, email);
				if (result)
				{
					

					res.data = result;
					res.flag = true;
					res.status = 200;
					res.message = "Account Successfully Created";
				}
				else
				{
					res.data = result;
					res.flag = false;
					res.status = 200;
					res.message = "Try different Email or Username";
				}
			}
			catch (Exception ex)
			{

				res.flag = false;
				res.status = 500;
				res.message = ex.Message;
			}

			return Json(new JsonResult(res));
		}

	}
}

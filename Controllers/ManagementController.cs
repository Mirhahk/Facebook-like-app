using Facebook.Common;
using Facebook.IRepository;
using Microsoft.AspNetCore.Mvc;

namespace Facebook.Controllers
{
    /*The ManagementController is a C# ASP.NET Core controller in a Facebook application. It is responsible for 
     * managing user profiles.
The controller has two actions:
The Index action retrieves a list of all users using the IProfile repository and returns a view with the user list.
The DeleteUser action deletes a user based on the provided user ID. It calls the deleteUser method of the IProfile
	repository and returns a JSON response indicating the status of the deletion process.

In summary, the ManagementController handles displaying and deleting user profiles in the Facebook application.*/
    public class ManagementController : Controller
	{
		private readonly IProfile _profile;
		public ManagementController(IProfile profile)
		{
			_profile = profile;
		}
		public IActionResult Index()
		{
			var list = _profile.GetAllUser();
			return View(list);
		}

		[HttpGet]
		public JsonResult DeleteUser(int id)
		{
			bool flag = false;
			flag = _profile.deleteUser(id);
			
			return Json(flag);
		}
	}
}

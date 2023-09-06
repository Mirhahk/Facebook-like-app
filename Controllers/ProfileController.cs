using Facebook.IRepository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Facebook.Controllers
{
    /*The ProfileController is a C# ASP.NET Core controller in a Facebook application that handles actions related
     * to user profiles. It has two actions: Index and Details.
The Index action returns a view for the profile page.
The Details action retrieves the profile details of a user based on the provided user ID and returns a view
	with the profile details.
In summary, the ProfileController is responsible for displaying the profile page and fetching profile details 
	for a user in the Facebook application.*/
    public class ProfileController : Controller
	{
		private readonly IProfile _profile;
		public ProfileController(IProfile profile)
		{
			_profile = profile;
		}
		// GET: ProfileController
		public ActionResult Index()
		{
			return View();
		}

		// GET: ProfileController/Details/5
		public ActionResult Details(int id)
		{
			var user = _profile.GetProfileById(id);
			return View(user);
		}

		


	}
}

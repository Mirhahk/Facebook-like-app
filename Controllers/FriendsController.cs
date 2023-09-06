using Facebook.Common;
using Facebook.IRepository;
using Facebook.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;

namespace Facebook.Controllers
{

    /* The FriendsController is a C# ASP.NET Core controller in a Facebook application. It handles actions related to
     * managing friends, friend requests, and friend notifications. Here's a brief summary of what it does:
     * The Index action retrieves a list of friends based on a username query parameter and returns a view with the 
     * friend list.
     * The AddFriend action adds a friend by accepting the friend's ID and the currently logged-in user's ID, and 
     * returns a JSON response indicating the success or failure of the friend addition.
	The GetAllNotification action retrieves all friend notifications for the currently logged-in user and returns a JSON 
	response containing the notifications.
	The FriendRequest action retrieves the details of a friend request based on the friend's ID and returns a view with the
	friend request details.
	The HandleFriendReqFinal action handles the finalization of a friend request by accepting the friend's ID and returns
	a JSON response indicating the success or failure of the request handling.
	The GetFriendDetails action retrieves the details of a friend based on the friend's ID and returns a JSON response
	containing the friend details.
	Overall, the FriendsController manages friend-related functionalities in the Facebook application, such as adding 
	friends, handling friend requests, and retrieving friend details and notifications.*/
    public class FriendsController : Controller
	{
		private readonly IFilter _filter;
		private readonly IFriendRequest _friendReq;
		private readonly IProfile _profile;
		public FriendsController(IFilter filter, IFriendRequest friendRequest, IProfile profile)
		{
			_filter = filter;
			_friendReq = friendRequest;
			_profile = profile;
		}
		public IActionResult Index()
		{

			var param = HttpContext.Request.Query["username"];
			var list = _filter.GetAllFriendsByUsername(param.ToString());
			return View(list);
		}


		public JsonResult AddFriend(int id)
		{
			bool flag = false;
			string getting_session = HttpContext.Session.GetString("User");
			var user = JsonConvert.DeserializeObject<UserLogin>(getting_session);
			flag = _friendReq.addFriend(id, user.Id);
			return Json(flag);
		}

		public JsonResult GetAllNotification()
		{
			Response res = new Response();
			string getting_session = HttpContext.Session.GetString("User");
			var user = JsonConvert.DeserializeObject<UserLogin>(getting_session);
			var ls = _friendReq.GetAllNotification(user.Id);
			if (ls.Count > 0)
			{
				res.data = ls;
				res.Count = ls.Count;
				res.status = 200;
				res.flag = true;
			}
			else
			{

				res.status = 200;
				res.flag = false;
				res.message = "Not Found any Notification";
			}
			return Json(res);
		}

		public IActionResult FriendRequest(int id)
		{
			//var data = _profile.GetProfileById(id);
			var data = _friendReq.GetProfileById(id);
			return View(data);
		}

		public JsonResult HandleFriendReqFinal(int id)
		{
			string getting_session = HttpContext.Session.GetString("User");
			var user = JsonConvert.DeserializeObject<UserLogin>(getting_session);
			var res = _friendReq.HandlingFriendRequest(id);
			return Json(res);
		}

		public JsonResult GetFriendDetails(int id)
		{
			var data = _friendReq.GettingDetailOfFriend(id);
			if (data != null)
			{

			}
			return Json(data);
		}
	}
}

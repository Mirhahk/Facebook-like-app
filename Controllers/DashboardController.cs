using Facebook.Common;
using Facebook.IRepository;
using Facebook.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.IO;
using System.Threading.Tasks;

namespace Facebook.Controllers
{

    /*The DashboardController is a C# ASP.NET Core controller in a Facebook application. It handles actions related 
     * to the dashboard functionality, including post creation, retrieval, deletion, and friend filtering. Here's 
     * a brief summary:
    The controller constructor is injected with three dependencies: IWebHostEnvironment (provides web hosting 
	environment information), IPost (manages posts), and IFilter (filters users).
    The Index action returns a view for the dashboard.
    The createpost action is an asynchronous task that handles the creation of a new post. It receives post data,
	including an optional image file, through a form submission. It saves the image file to a designated folder, 
	creates a new Posts object with the post details, and saves the post using the CreatePosts method of the 
	IPost repository. It returns a JSON response indicating the status of the post creation process.
    The GetPost action retrieves all posts associated with the currently logged-in user. It fetches the user ID
	from the session, calls the GetPostsByUserId method of the IPost repository, and returns a JSON response 
	containing the retrieved posts.
    The deletepost action deletes a post with the specified postId. It converts the postId to an integer, 
	calls the deletePostByID method of the IPost repository to delete the post, and returns a JSON response 
	indicating the status of the deletion process.
    The GetFriendsFilteringOutByUsername action retrieves a list of friends filtered by the given username.
	It calls the FilterUsers method of the IFilter repository, passing the username parameter, and returns a
	JSON response containing the filtered friends.
    The GetAllFriendsFilteringOut action retrieves all friends without any filtering. It calls the GetAllFilterUsers
	method of the IFilter repository and returns a JSON response containing all the friends.
    Overall, the DashboardController handles post management and friend filtering functionalities in the Facebook
	application's dashboard.*/

    public class DashboardController : Controller
	{
		private readonly IWebHostEnvironment _webHostEnvironment;
		private readonly IPost _post;
		private readonly IFilter _filter;
		public DashboardController(IWebHostEnvironment webHostEnvironment, IPost post, IFilter filter)
		{
			_post = post;
			_webHostEnvironment = webHostEnvironment;
			_filter = filter;
		}

		public IActionResult Index()
		{
			return View();
		}

		public async Task<JsonResult> createpost()
		{
			bool flag = false;
			Response res = new Response();
			try
			{
				var file = Request.Form.Files["file"];
				var title = Request.Form["title"];
				var description = Request.Form["description"];
				var sessionUser = new Byte[20];
				bool user = HttpContext.Session.TryGetValue("User", out sessionUser);
				UserLogin users = new UserLogin();
				if (user)//checking condition if user is login or not
				{
					//get login user
					users = JsonConvert.DeserializeObject<UserLogin>(System.Text.Encoding.UTF8.GetString(sessionUser));

				}
				if (file != null && file.Length > 0)
				{
					string extension = Path.GetExtension(file.FileName);
					if (extension == ".jfif" || extension == ".jpeg" || extension == ".jpg" || extension == ".png")
					{
						string path = Path.Combine(_webHostEnvironment.WebRootPath, "Images");
						if (!Directory.Exists(path))
						{
							Directory.CreateDirectory(path);
						}
						string subFolderPath = Path.Combine(_webHostEnvironment.WebRootPath, "Images", users.Username);
						if (!Directory.Exists(subFolderPath))
						{
							Directory.CreateDirectory(subFolderPath);
						}

						var destPath = Path.Combine(subFolderPath, file.FileName);
						using (var stream = new FileStream(destPath, FileMode.Create, FileAccess.ReadWrite))
						{
							await file.CopyToAsync(stream);

						}
						Posts obj = new Posts();
						obj.title = title;
						obj.description = description;
						obj.filepath = destPath;
						obj.createdAt = DateTime.Now;
						obj.userId = users.Id;
						flag = _post.CreatePosts(obj);
					}

				}
				if (flag)
				{
					var listPosts = _post.GetPostsByUserId(users.Id);
					if (listPosts.Count > 0)
					{
						res.data = listPosts;
					}
					else
					{
						res.data = "Not any Post Found";
					}
					res.flag = true;
					res.status = 200;
					res.message = "Post created Successfully";
				}
				else
				{

					var listPosts = _post.GetPostsByUserId(users.Id);
					if (listPosts.Count > 0)
					{
						res.data = listPosts;
						res.message = "Incorrect File Format Try again";
						res.flag = false;
					}
					else
					{
						res.data = "Not any Post Found";
					}
					res.flag = false;
					res.status = 200;
					res.message = "Something went wrong Try again";
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

		[HttpGet]
		public JsonResult GetPost()
		{
			Response res = new Response();
			try
			{
				var sessionUser = new Byte[20];
				bool user = HttpContext.Session.TryGetValue("User", out sessionUser);
				UserLogin users = new UserLogin();
				if (user)//checking condition if user is login or not
				{
					//get login user
					users = JsonConvert.DeserializeObject<UserLogin>(System.Text.Encoding.UTF8.GetString(sessionUser));

				}
				//getting all posts against user id
				var PostsList = _post.GetPostsByUserId(users.Id);
				if (PostsList.Count > 0)
				{
					res.data = PostsList;
					res.flag = true;
					res.status = 200;
					res.message = "";
				}
				else
				{
					res.flag = false;
					res.status = 200;
					res.message = "Not Found any Post";
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


		[HttpGet]
		public JsonResult deletepost(string postId)
		{
			Response res = new Response();
			try
			{
				int id = (int)Convert.ToInt64(postId);

				var result = _post.deletePostByID(id);
				if (result)
				{
					res.status = 200;
					res.message = "Post Has been Deleted";
					res.flag = true;
				}
				else
				{
					res.status = 200;
					res.message = "Something went wrong";
					res.flag = false;
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


		

		[HttpGet]
		public JsonResult GetFriendsFilteringOutByUsername(string username)
		{
			Response res = new Response();
			try
			{
				var filteredList = _filter.FilterUsers(username);
				if (filteredList.Count > 0)
				{
					res.data = filteredList;
					res.status = 200;
					res.flag = true;
					res.keyword = username;
					res.Count = filteredList.Count;
				}
				else
				{
					res.data = "Data not found";
					res.flag = false;
					res.status = 200;
					res.keyword = username;
					res.Count = filteredList.Count;
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


		[HttpGet]
		public JsonResult GetAllFriendsFilteringOut()
		{
			Response res = new Response();
			try
			{
				var filteredList = _filter.GetAllFilterUsers();
				if (filteredList.Count > 0)
				{
					res.data = filteredList;
					res.status = 200;
					res.flag = true;
				}
				else
				{
					res.data = "Data not found";
					res.flag = false;
					res.status = 200;
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

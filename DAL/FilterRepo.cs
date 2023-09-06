using Facebook.Context;
using Facebook.IRepository;
using Facebook.Models;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;

namespace Facebook.DAL
{
    //the FilterRepo class provides functionality to filter and retrieve users and friends based on
	//certain criteria in the Facebook application.
    public class FilterRepo : IFilter
	{
		private readonly DataContext _context;
		private readonly IHttpContextAccessor _httpContextAccessor;

		public FilterRepo(DataContext context, IHttpContextAccessor httpContextAccessor)
		{
			//var sessionUser = new Byte[20];
			//// bool user = Context.Session.TryGetValue("User", out sessionUser);
			//HttpContext.ReferenceEquals("User", false);
			////if (user)
			////{
			////    var getUser = JsonConvert.DeserializeObject<UserLogin>(System.Text.Encoding.UTF8.GetString(sessionUser));


			////                        < span > @getUser.Username.ToUpper() </ span >

			////                    }
			_httpContextAccessor = httpContextAccessor;
			_context = context;
		}

		public UserLogin getSession()
		{
			string user = _httpContextAccessor.HttpContext.Session.GetString("User");
			var getUser = JsonConvert.DeserializeObject<UserLogin>(user);
			return getUser;
		}
		public List<UserLogin> FilterUsers(string username)
		{
			List<UserLogin> users = new List<UserLogin>();
			var gettinUsers = getSession();
			users = _context.Login.Where(x => x.Username.Contains(username) && x.Username.ToLower() != "admin" && x.Id != gettinUsers.Id).Take(2).ToList();

			return users;

		}

		public List<UserLogin> GetAllFilterUsers()
		{
			List<UserLogin> users = new List<UserLogin>();
			var gettinUsers = getSession();

			users = _context.Login.Where(x => x.Username.ToLower() != "admin" && x.Id != gettinUsers.Id).Take(5).ToList();

			return users;
		}

		public List<UserLogin> GetAllFriendsByUsername(string username)
		{
			List<UserLogin> users = new List<UserLogin>();
			List<UserLogin> ls = new List<UserLogin>();
			List<UserFriend> userfriend = new List<UserFriend>();


			var gettinUsers = getSession();
			//users = _context.Login.Where(x => x.Username.Contains(username) && x.Username.ToLower() != "admin" && x.Id != gettinUsers.Id).ToList();
			var query = _context.Login.Where(x => x.Username.Contains(username) && x.Username.ToLower() != "admin" && x.Id != gettinUsers.Id).OrderBy(x => x.Id).ToList();
			foreach (var user in query)
			{
				var query1 = _context.UserFriends.FirstOrDefault(x => x.UserId == user.Id);
				userfriend.Add(query1);
			}
			foreach (var item in userfriend)
			{
				if (item != null)
				{
					UserLogin singleContain = new UserLogin();
					singleContain = query.Where(x => x.Id != item.UserId).FirstOrDefault();
					singleContain.isAlreadyFriend = (bool)item.isAlreadyYourFriend;
					ls.Add(singleContain);
				}
			}
			ls = ls.OrderBy(x => x.Id).ToList();
			var d = query.Except(ls).ToList();
			foreach (var item in d)
			{

				ls.Add(item);
			}
			//}
			//var query = (from l in _context.Login
			//			 join req in _context.UserFriends on l.Id equals req.UserId
			//			  into bGroup
			//			 from req in bGroup.DefaultIfEmpty()
			//			 where l.Username.Contains(username) && l.Username.ToLower() != "admin" && l.Id != gettinUsers.Id

			//			 select new UserLogin()
			//			 {
			//				 Id = l.Id,
			//				 Username = l.Username,
			//				 isFriendRequest = req.isFriendRequest,
			//				 FriendId = req.FriendId,
			//				 UserFriend_pk_id = req.id,
			//				 isAlreadyFriend = (bool)req.isAlreadyYourFriend

			//			 }).ToList();
			//query = query.Where(x => x.FriendId == gettinUsers.Id).ToList();

			return query;
		}
	}
}

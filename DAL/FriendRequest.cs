using Facebook.Context;
using Facebook.IRepository;
using Facebook.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.VisualBasic;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;

namespace Facebook.DAL
{

    //The FriendRequest class handles friend requests and related functionalities in a Facebook application.
	//It has methods to add friends, retrieve friend notifications, accept friend requests, retrieve friend
	//profiles, and delete friends.

    The class uses a DataContext object and an IHttpContextAccessor object for database access and HTTP context management.

    In summary, the FriendRequest class facilitates the management of friend requests and interactions between users in the Facebook application.

    public class FriendRequest : IFriendRequest
	{
		private readonly DataContext _context;
		private readonly IHttpContextAccessor _httpContextAccessor;
		public FriendRequest(DataContext context, IHttpContextAccessor httpContextAccessor)
		{
			_context = context;
			_httpContextAccessor = httpContextAccessor;
		}
		public UserLogin getSession()
		{
			string user = _httpContextAccessor.HttpContext.Session.GetString("User");
			var getUser = JsonConvert.DeserializeObject<UserLogin>(user);
			return getUser;
		}
		public bool addFriend(int friendId, int id)
		{
			bool flag = false;
			UserFriend userFriend = new UserFriend();
			userFriend.UserId = friendId;
			userFriend.FriendId = id;
			userFriend.isFriendRequest = true;
			var isExist = _context.UserFriends.FirstOrDefault(x => x.UserId == friendId && x.FriendId == id);
			if (isExist != null)
			{
				flag = false;
			}
			else
			{

				_context.UserFriends.Add(userFriend);
				int res = _context.SaveChanges();
				if (res > 0)
					flag = true;
			}


			return flag;
		}


		public List<UserLogin> GetAllNotification(int id)
		{
			List<UserLogin> users = new List<UserLogin>();
			var currentAccountSentReq = _context.UserFriends.Where(x => x.UserId == id && x.isFriendRequest == true).ToList();
			//string[] ids = new string[currentAccountSentReq.Count()];
			if (currentAccountSentReq.Count() > 0)
			{
				foreach (var item in currentAccountSentReq)
				{
					if (item.isFriendRequest)
					{
						var user = getSession();
						if (user.Id != id)
						{

							var get_exact_user = _context.Login.FirstOrDefault(x => x.Id == id);
							if (get_exact_user != null)
							{
								var query = _context.Login.FirstOrDefault(x => x.Id == item.UserId);
								users.Add(query);
							}
						}
						else
						{
							var query = _context.Login.FirstOrDefault(x => x.Id == item.FriendId);
							users.Add(query);
						}
						//users = (from l in _context.Login
						//		 join req in _context.UserFriends on l.Id equals req.FriendId

						//		 where l.Username.ToLower() != "admin" && req.isFriendRequest == true && req.UserId != id

						//		 select new UserLogin()
						//		 {
						//			 Id = req.UserId,
						//			 Username = l.Username,
						//			 isFriendRequest = req.isFriendRequest,
						//			 FriendId = req.FriendId,
						//		 }).ToList();
					}

				}
			}

			return users;
		}


		public bool HandlingFriendRequest(int friendId, int userId)
		{
			bool flag = false;
			var query = _context.UserFriends.FirstOrDefault(x => x.UserId == userId && x.FriendId == friendId);
			if (query != null)
			{
				query.isFriendRequest = false;
				_context.UserFriends.Update(query);
				int res = _context.SaveChanges();
				if (res > 0)
					flag = true;
			}

			return flag;
		}
		public bool HandlingFriendRequest(int id)
		{
			bool flag = false;
			var query = _context.UserFriends.FirstOrDefault(x => x.id == id);
			if (query != null)
			{
				query.isFriendRequest = false;
				query.isAlreadyYourFriend = true;
				_context.UserFriends.Update(query);
				int res = _context.SaveChanges();
				if (res > 0)
					flag = true;
			}

			return flag;
		}
		public UserLogin GettingDetailOfFriend(int id)
		{
			var query = (from l in _context.Login
						 join req in _context.UserFriends on l.Id equals req.FriendId
						 where l.Username.ToLower() != "admin" && req.isFriendRequest == true && l.Id == id

						 select new UserLogin()
						 {
							 Id = l.Id,
							 Username = l.Username,
							 isFriendRequest = req.isFriendRequest,
							 FriendId = req.FriendId,
						 }).FirstOrDefault();
			return query;
		}

		public UserLogin GetProfileById(int id)
		{
			var user = getSession();
			var query = (from req in _context.UserFriends
						 join l in _context.Login on req.UserId equals l.Id
						 where req.FriendId == id && req.UserId == user.Id

						 select new UserLogin()
						 {
							 Id = l.Id,
							 Username = l.Username,
							 isFriendRequest = req.isFriendRequest,
							 FriendId = req.FriendId,
							 UserFriend_pk_id = req.id
						 }).FirstOrDefault();
			var data = _context.Login.FirstOrDefault(x=>x.Id == query.FriendId);
			UserLogin userLogin = new UserLogin();
			data.UserFriend_pk_id = query.UserFriend_pk_id;
			
			return data;
		}

		public bool deleteFriend(int id)
		{
			return true;
		}
	}
}

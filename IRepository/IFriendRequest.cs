using Facebook.Models;
using System.Collections.Generic;

namespace Facebook.IRepository
{
	public interface IFriendRequest
	{
		public bool addFriend(int id, int friendId);
		public List<UserLogin> GetAllNotification(int id);
		public bool HandlingFriendRequest(int userId, int friendId);
		public bool HandlingFriendRequest(int id);
		public UserLogin GettingDetailOfFriend(int id);
		public UserLogin GetProfileById(int id);
		public bool deleteFriend(int id);
	}
}

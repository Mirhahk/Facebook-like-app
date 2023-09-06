using Facebook.Models;
using System.Collections.Generic;

namespace Facebook.IRepository
{
	public interface IFilter
	{
		public List<UserLogin> FilterUsers(string username);
		public List<UserLogin> GetAllFilterUsers();

		public List<UserLogin> GetAllFriendsByUsername(string username);
	}

}

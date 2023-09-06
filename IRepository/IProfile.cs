using Facebook.Models;
using System.Collections.Generic;

namespace Facebook.IRepository
{
	public interface IProfile
	{

		public UserLogin GetProfileById(int id);

		public List<UserLogin> GetAllUser();

		public bool deleteUser(int id);
	}
}


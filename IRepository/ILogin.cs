using Facebook.Models;
using Facebook.ViewModel;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace Facebook.IRepository
{
	public interface ILogin
	{
		public View_userlogin GetUser(string username , string password);

		public bool CreateUser(string username, string password , string email);
	}
}

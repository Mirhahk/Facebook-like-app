using Dapper;
using Facebook.Context;
using Facebook.IRepository;
using Facebook.Models;
using Facebook.ViewModel;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.Extensions.Configuration;
using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Facebook.DAL
{

    /*The Login class is responsible for user authentication and account creation in a Facebook application.
     * It implements the ILogin interface and uses a DataContext object for database access. It provides
     * methods to retrieve user information based on username and password (GetUser), as well as create 
     * new user accounts (CreateUser). It utilizes Dapper for executing a stored procedure and mapping the
     * results. Overall, it handles user authentication and account creation functionalities in the
     * Facebook application.*/
    public class Login : ILogin
	{
		private readonly DataContext _context;
		public Login(DataContext context)
		{
			_context = context;
		}
		public View_userlogin GetUser(string username, string password)
		{
			var query = new View_userlogin();

			try

			{

				
				//UserLogin user = new UserLogin();
				//var Username = new SqlParameter("@username", username);
				//var Password = new SqlParameter("@password", password);

				//var user = _context.Login.FirstOrDefault(x => (x.Username == username || x.Email == username) && x.Password == password);
				//query = (from l in _context.Login
				//		 join r in _context.Roles on l.Id equals r.userLoginId
				//		 join r_u in _context.RoleUsers on r.RoleId equals r_u.Id
				//		 where (l.Username == username || l.Email == username) && l.Password == password
				//		 select new UserLogin()
				//		 {
				//			 Id = l.Id,
				//			 Username = l.Username,
				//			 Password = l.Password,
				//			 Datetime = l.Datetime,
				//			 Email = l.Email,
				//			 roleId = r_u.Id,
				//			 roleName = r_u.roleName
				//		 }
				//			).FirstOrDefault();
				using (var connection = new SqlConnection(Helper.GetConnectionStr()))
				{
					connection.Open();

					var parameters = new DynamicParameters();
					// Set any input parameters for the stored procedure if necessary
					parameters.Add("@username", username);
					parameters.Add("@password", password);

					query = connection.Query<View_userlogin>(
						"LoginGetUser",
						parameters,
						commandType: CommandType.StoredProcedure
					).FirstOrDefault();
				}

			}
			catch (Exception ex)
			{

			}
			return query;

		}

		public bool CreateUser(string username, string password, string email)
		{
			bool flag = false;
			UserLogin userLogin = new UserLogin();
			userLogin.Username = username;
			userLogin.Email = email;
			userLogin.Password = password;
			var query = _context.Login.FirstOrDefault(x => x.Username == username || x.Email == email);
			if (query == null)
			{
				_context.Login.Add(userLogin);
				int result = _context.SaveChanges();
				if (result > 0)
				{
					Role role = new Role();
					role.userLoginId = userLogin.Id;
					role.RoleId = 2;
					_context.Add(role);
					_context.SaveChanges();
					flag = true;
				}
			}

			return flag;
		}
	}
}

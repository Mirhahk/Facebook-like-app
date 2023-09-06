using Dapper;
using Facebook.Context;
using Facebook.IRepository;
using Facebook.Models;
using Facebook.ViewModel;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Facebook.DAL
{

    /*The CreatePosts method inserts a new post into the database by executing a stored procedure. It takes a Posts 
     * object as input, which contains the post's details.

The deletePostByID method deletes a post from the database based on its ID. It first checks if the post exists, and 
	if so, it removes it from the context and saves the changes.

The GetPostsByUserId method retrieves posts from the database based on a user's ID. It performs a join operation 
	between the Login and Posts tables and returns a list of 
	Posts objects containing the relevant properties.*/
    public class Post : IPost
	{
		private readonly DataContext _context;
		public Post(DataContext context)
		{
			_context = context;
		}
		public bool CreatePosts(Posts post)
		{

			//here i am filling object and posting in database
			bool flag = false;
			int isInserted = 0;
			//Posts posts = new Posts();
			//posts.title = post.title;
			//posts.description = post.description;
			//posts.filepath = post.filepath;
			//posts.userId = post.userId;
			//posts.createdAt = post.createdAt;
			//this is posting command

			using (var connection = new SqlConnection(Helper.GetConnectionStr()))
			{
				connection.Open();

				var parameters = new DynamicParameters();
				// Set any input parameters for the stored procedure if necessary
				parameters.Add("@title", post.title);
				parameters.Add("@description", post.description);
				parameters.Add("@filepath", post.filepath);
				parameters.Add("@createdAt", post.createdAt);
				parameters.Add("@userId", post.userId);
				parameters.Add("@result", dbType: DbType.Int32, direction: ParameterDirection.Output);

				connection.Execute(
						"AddPost",
						parameters,
						commandType: CommandType.StoredProcedure
					);
				// Retrieve the output parameter value
				isInserted = parameters.Get<int>("@result");

			}

			//_context.Add(posts);
			//now saving in database
			//int res = _context.SaveChanges();
			//if (res > 0)
			//	flag = true;

			if (isInserted > 0)
				flag = true;

			return flag;
		}

		public bool deletePostByID(int postId)
		{
			bool flag = false;
			//this is I am checking from database basically it is fetching the record form database if it is  then->
			var isPostHas = _context.Posts.FirstOrDefault(x => x.Id == postId);
			if (isPostHas != null)
			{
				//I am removing okay
				_context.Posts.Remove(isPostHas);
				//again saving
				int res = _context.SaveChanges();
				if (res > 0)
					flag = true;
			}

			return flag;
		}

		public List<Posts> GetPostsByUserId(int userId)
		{
			//this is join basically we are fetching data from 2 or more tables from db
			List<Posts> query = (from login in _context.Login
								 join cp in _context.Posts on
								 login.Id equals cp.userId
								 where cp.userId == userId
								 select new Posts
								 {
									 Id = cp.Id,
									 title = cp.title,
									 filepath = cp.filepath,
									 description = cp.description,
									 createdAt = cp.createdAt,
									 userId = userId
								 }
								 ).ToList();

			return query;

		}
	}
}

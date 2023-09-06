using Facebook.Models;
using System;
using System.Collections.Generic;

namespace Facebook.IRepository
{
	public interface IPost
	{
		public bool CreatePosts(Posts post);
		public List<Posts> GetPostsByUserId(int userId);

		public bool deletePostByID(int postId);
	}
}

class Account::PostsController < ApplicationController
	def index
		@posts = current_user.posts
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		flash[:alert] = "Post Deleted"
		redirect_to account_posts_path
	end
	
end

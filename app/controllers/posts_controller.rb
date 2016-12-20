class PostsController < ApplicationController
	before_filter :authenticate_user!, :only => [:new, :create]
	def new
		@group = Group.find(params[:group_id])
		@post = Post.new
	end

	def create
		@group = Group.find(params[:group_id])
		@post = Post.new(post_params)
		@post.user = current_user
		@post.group = @group

		if @post.save
			redirect_to group_path(@group)
		else
			render :new
		end
	end

	def edit
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:id])
	end

	def update
		# @post = Post.find(post_params)
		if @post.update(post_params)
			redirect_to account_posts_path, notice: "Update Successfully"
		# else
		# 	render :edit
		# end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		flash[:alert] = "Post Deleted"
		redirect_to account_posts_path
	end

	private

	def post_params
		params.require(:post).permit(:content)
	end
end

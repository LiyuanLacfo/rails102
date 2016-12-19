class GroupsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update]
	before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
	def index
		@groups = Group.all
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(group_params)
		@group.user = current_user
		if @group.save
			redirect_to groups_path
		else
			render :new
		end
		# @group.save
		# 	redirect_to groups_path
	end

	def show
		@group = Group.find(params[:id])
		@posts = @group.posts.recent
	end

	def edit
	end

	def update
		if @group.update(group_params)
			redirect_to groups_path, notice: "Update Successfully"
		else
			render :edit
		end
		# @group.update(group_params)

		# redirect_to groups_path notice: "Update Successfully"
	end

	def destroy
		@group.destroy
		flash[:alert] = "Group Deleted"
		redirect_to groups_path
	end

	def join
		@group = Group.find(params[:id])
		if !current_user.is_memeber_of?(@group)
			current_user.join!(@group)
			flash[:notice] = "加入本版成功"
		else
			flash[:warning] = "您已经是本班成员"
		end

		redirect_to groups_path(@group) 
	end

	def quit
		if current_user.is_member_of?(@group)
			current_user.quit!(@group)
			flash[:notice] = "您已退出本版"
		else
			flash[:warning] = "您不是本版成员，怎么退出"
		end

		redirect_to group_path(@group)
	end

	private

	def find_group_and_check_permission
		@group = Group.find(params[:id])
		if current_user != @group.user
			redirect_to groups_path, alert: "You have no permission"
		end
	end

	def group_params
		params.require(:group).permit(:title, :description)
	end
end

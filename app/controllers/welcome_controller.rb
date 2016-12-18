class WelcomeController < ApplicationController
	def index
		flash[:warning] = "这是警告信息"
	end
end

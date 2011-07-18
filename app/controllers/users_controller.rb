class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.name  # html is escaped by default
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  
end

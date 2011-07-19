class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.name  # html is escaped by default
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user       # signs in user after sign up
      #flash[:success] = "Welcome to the Sample App!"
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!", }
    else
      @title = "Sign up"
      render 'new'
    end
  end
end

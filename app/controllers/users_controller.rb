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
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!"}
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile updated" }
    else
      @title = "Edit user"
      render 'edit'
    end
  end
end

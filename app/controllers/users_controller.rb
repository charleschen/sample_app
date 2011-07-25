class UsersController < ApplicationController
  before_filter :authenticate,  :except => [:show, :new, :create]  #:only => [:index, :edit, :update, :destroy]
  before_filter :correct_user,  :only => [:edit, :update]
  before_filter :admin_user,    :only => :destroy
  
  def index
    @title = "All users"
    
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name  # html is escaped by default
    @microposts = @user.microposts.paginate(:page => params[:page])
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
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
    #raise request.inspect looking at request attributes
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile updated" }
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, :flash => {:success => "destroyed"}
  end
  
  private
    
    # def authenticate
    #       #flash[:notice] = "Please sign in to access this page"
    #       deny_access unless signed_in?
    #     end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(user)
    end
end

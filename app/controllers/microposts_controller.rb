class MicropostsController < ApplicationController
  before_filter :authenticate
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    
    if @micropost.save
      redirect_to root_url, :flash => { :success => "Micropost created!"}
    else
      render 'pages/home'
    end
  end
  
  def destroy
    
  end
  
  private
    def authenticate
      #flash[:notice] = "Please sign in to access this page"
      deny_access unless signed_in?
    end
end
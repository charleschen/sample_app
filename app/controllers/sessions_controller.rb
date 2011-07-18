class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                            params[:session][:password])
                            
    if user.nil?
      #flash[:error] = "Invalid email/password combination."   last for 1 request
      flash.now[:error] = "Invalid email/password combination."  # instant, no waiting for request
      @title = "Sign in"
      render 'new' # doesn't count as a new request
    else
      # success
    end
  end
  
  def destroy
  end

end

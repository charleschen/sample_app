class RelationshipsController < ApplicationController
  before_filter :authenticate
  
  def create
    #raise params.inspect
    @user = User.find_by_id(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js # if there is nothing then rails will automatically run javascript named by the action (create.js.erb) 
    end  
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js 
    end
  end
  
end
require 'spec_helper'

describe "FriendlyFowardings" do
  it "should forawrd to the requested page after signin" do
    user = Factory(:user)
    
    visit edit_user_path(user) # should be redirected to signin page
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button 'Sign in'
    response.should render_template('users/edit')
    visit signout_path
    
    visit signin_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button 'Sign in'
    response.should render_template('users/show')
    
  end
end

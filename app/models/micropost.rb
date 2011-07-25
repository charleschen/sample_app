# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  validates :content, :presence => true, :length => { :maximum => 140}
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'  # good practice to put the table you are modifying

  # User.first.following.map { |user| user.id }
  # is the same as
  # User.first.following.map(&:id)
  
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  private 
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships 
                        WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id", :user_id => user)  # since this is a Class method, dunt need Micropost.where
    end
end

# # def self.from_users_followed_by(user)
# #     #if user is following a lot of people, this whole list will take up a lot of memory
# followed_ids = user.following.map(&:id).join(", ")  # SQL commands need a string of the users, separated by ", "
# where("user_id IN (#{followed_ids}) OR user_id = ?", user)  # since this is a Class method, dunt need Micropost.where
# 
# #   end


#Microposts.from_users_followed_by(user)


# SELECT * FROM microposts
# WHERE user_id IN (<list of ids>) OR user_id = <user id>   micropost being followed by
# Micropost.where("user_id = ?", id)

#Micropost.where("user_id IN (#{followed_ids}) OR user_id = ?", user)

class User < ActiveRecord::Base
  attr_accessor :password # virtual attribute that's created
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\-\d.]+\.[a-z]+\z/i
  
  # uniqueness validation from rails isn't always completely unique
  validates :name,  :presence   => true, 
                    :length     => { :maximum => 50 }
  
  validates :email, :presence   => true,
                    :format     => { :with => email_regex},
                    :uniqueness => { :case_sensitive => false}
  
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..40 }
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#


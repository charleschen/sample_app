# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#


class User < ActiveRecord::Base
  attr_accessor :password # virtual attribute that's created
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_many :microposts, :dependent => :destroy
  
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
                        
  # registering a callback - method calling at a particular time during creation of instance
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  # or class << self
  #  def authenticate
  #  end
  #end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
        
    # return nil if user.nil?
    # return user if user.has_password?(submitted_password)
    
    (user && user.has_password?(submitted_password)) ? user : nil
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = User.find_by_id(id)
    (user && user.salt == cookie_salt) ? user :nil  # turnary operator
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
end

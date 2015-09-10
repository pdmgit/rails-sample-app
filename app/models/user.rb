class User < ActiveRecord::Base
  REGEX_valid_email_address = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  before_save { self.email = self.email.downcase }
  
  validates( :name, presence: true, length: { maximum: 50 } )

  validates( :email, presence: true, length: { maximum: 255 } )

  validates( :email, format: { with: REGEX_valid_email_address }, uniqueness: { case_sensitive: false } )
  
  validates( :password, presence: true, length: { minimum: 6 } )

  has_secure_password
end

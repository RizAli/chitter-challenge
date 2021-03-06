require 'bcrypt'
# require_relative 'password'

class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String, :unique => true, :message => "This email is already taken"
  property :name,  String
  property :user_name, String, :unique => true, :message => "This username is already taken"
  property :password_digest, Text

  has n, :peeps, :through => Resource



  validates_confirmation_of :password, :message => "Sorry, your password don't match"


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(:email => email)

    if user && BCrypt::Password.new(user.password_digest) ==  password
      user
    else
      nil
    end
  end
end


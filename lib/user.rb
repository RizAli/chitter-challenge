require 'bcrypt'
class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :name,  String
  property :user_name, String
  property :password_digest, Text

  has n, :peeps, :through => Resource


  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end


end


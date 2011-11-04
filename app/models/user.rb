class User
  include Mongoid::Document

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end

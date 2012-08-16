class User < ActiveRecord::Base
  validates_presence_of :role
  validates :username, :uniqueness => true
  has_many :doctors
  has_many :patients
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable , :authentication_keys => [:username]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role, :edit_confirmed, :remember_me, :username
end

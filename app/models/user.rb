class User < ActiveRecord::Base

  has_many :user_roles
  has_many :roles, :through => :user_roles

  has_one :doctor
  has_one :patient

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role, :edit_confirmed, :remember_me, :doctor_attributes

  accepts_nested_attributes_for :doctor
end

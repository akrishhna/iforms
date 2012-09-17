class User < ActiveRecord::Base

  validates_presence_of :role
  validates :username, :uniqueness => true

  has_many :doctors
  has_many :patients
  has_many :user_service_providers
  has_many :service_providers, :through => :user_service_providers
  has_many :girls_scouts
  has_many :girl_scouts_activities
  has_many :girl_scouts_activity_permission_forms

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable , :authentication_keys => [:username]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role, :edit_confirmed, :remember_me, :username

  after_create :resolve_girl_scout

  def resolve_girl_scout
    @girl_scout = GirlsScout.find_by_email(self.email)
    if @girl_scout.present?
      @girl_scouts_activity_permission_form = GirlScoutsActivityPermissionForm.find_all_by_girls_scout_id(@girl_scout.id)
     @girl_scouts_activity_permission_form.each do |pf|
       pf.user_id = @girl_scout.user_id if pf.user_id.nil?
       pf.save
     end
    end
  end
end

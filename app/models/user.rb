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
  has_many :display_messages, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_one :girl_scout_troop_leader_profile
  has_many :girl_scout_diamond_activities
  has_many :girl_scout_diamond_activity_permission_forms
  has_one :admin_user

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable, :authentication_keys => [:username]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role, :edit_confirmed, :remember_me, :username
  attr_accessible :service_provider_ids, :status
  attr_accessible :girl_scout_troop_leader_profile_attributes
  accepts_nested_attributes_for :girl_scout_troop_leader_profile


  after_create :resolve_girl_scout, :resolve_patient_user_id

  def resolve_girl_scout
    @girl_scout = GirlsScout.find_by_email(self.email)
    if @girl_scout.present?
      @user = User.find_by_email(@girl_scout.email)
      @girl_scouts_activity_permission_form = GirlScoutsActivityPermissionForm.find_all_by_girls_scout_id(@girl_scout.id)
      @girl_scouts_activity_permission_form.each do |pf|
        pf.user_id = @user.id if pf.user_id.nil?
        pf.save
      end
    end
  end

  def resolve_patient_user_id
    appointments = Appointment.where('email=?',self.email)
    appointments.each do|appointment|
      appformjoin = Appformjoin.where('appointment_id=? and patient_user_id IS NULL',appointment.id)
      appformjoin.patient_user_id = self.id
      appformjoin.save
    end
  end
end

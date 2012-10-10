class DisplayMessage < ActiveRecord::Base

  belongs_to :user

  validates_uniqueness_of :message_type, :scope => :user_id

end

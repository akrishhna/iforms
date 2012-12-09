class BoyScoutsActivity < ActiveRecord::Base
  belongs_to :user
  has_many :boy_scouts_activity_consent_forms, :dependent => :destroy

  def self.activity_activity_consent_form_pdf_generater(activity, permission_form_path)
    @activity = activity
    form_pdf_path = "#{BOY_SCOUTS_ACTIVITY_CONSENT_FORM_PATH}"
    @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)
    @pdftk.fill_form(form_pdf_path, permission_form_path, {
      "Adult_Tour_Leader" => @activity.leader_first_name.to_s + ' ' + @activity.leader_last_name.to_s,
      "Adult_Tour_Leader_Phone" => (@activity.leader_phone_1 ? (@activity.leader_phone_1.to_s + '-') : '') + (@activity.leader_phone_2 ? (@activity.leader_phone_2.to_s + '-') : '') + @activity.leader_phone_3.to_s ,
      "Adult_Tour_Leader_Email" => @activity.leader_email,
      "Date_From" => @activity.activity_date_begin,
      "Date_To" => @activity.activity_date_end,
      "Has_approval_to_participate" => @activity.activity_name
    })
    # raise @pdftk.fields(form_pdf_path).to_yaml
  end
end

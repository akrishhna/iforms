class Consumer::BoyScoutsController < ApplicationController

  def index
    session["consumer_tab_index"] = 1
    @results = []
    @boy_scouts_activity_permission_forms = current_user.boy_scouts_activity_consent_forms.order("updated_at DESC")
    @boy_scouts_activity_permission_forms.each do |pf|
      item = {}
      item[:id] = pf.id
      item[:boy_scout] = (pf.boy_scouts_roster.first_name + ' ' + pf.boy_scouts_roster.last_name rescue "")
      item[:activity_name] = pf.boy_scouts_activity.activity_name
      item[:activity_date_begin] = pf.boy_scouts_activity.activity_date_begin
      item[:activity_date_end] = pf.boy_scouts_activity.activity_date_end
      item[:due_date] = pf.boy_scouts_activity.activity_signed_permission_due_date
      item[:boy_scout_attending] = pf.attending
      item[:status] = pf.status
      item[:updated_at] = pf.updated_at
      @results << item
    end
    render :layout => false if request.xhr?
  end

  def view_boy_scout_permission_form
    session["consumer_tab_index"] = 1
    @boy_scouts_permission_form = BoyScoutsActivityConsentForm.find_by_id(params[:id])
    @activity = @boy_scouts_permission_form.boy_scouts_activity
    @boy_scout = @boy_scouts_permission_form.boy_scouts_roster
    if @boy_scouts_permission_form.status == "Submitted" || @boy_scouts_permission_form.status == "Updated"
      @boy_scouts_permission_form.status = "Submitted"
    else
      @boy_scouts_permission_form.status = 'In Progress'
    end

    @boy_scouts_permission_form.save(:validate => false)
    @boy_scouts_permission_form.email = @boy_scout.email
    @recent_submitted_form = current_user.boy_scouts_activity_consent_forms.where('status in (?) and boy_scouts_roster_id=?', ['Sent', 'Submitted', 'Updated'], @boy_scout.id).order('updated_at').last
    if @recent_submitted_form
      @boy_scouts_permission_form.attributes.each do |attr_name, attr_val|
        unless attr_val
          @boy_scouts_permission_form[attr_name] = @recent_submitted_form[attr_name]
          @boy_scouts_permission_form[:email] = @boy_scout.email
        end
      end
    end
  end

  def boy_scouts_permission_form
    @boy_scouts_permission_forms = BoyScoutsActivityConsentForm.find_by_id(params[:boy_scouts_activity_consent_form][:id])
    @boy_scouts_permission_forms.attributes = params[:boy_scouts_activity_consent_form]
    @boy_scouts_permission_forms.save(:validate => false)
  end

  def send_permission_form_to_troop_leader
    @boy_scouts_permission_form = BoyScoutsActivityConsentForm.find(params[:id])
    @activity = @boy_scouts_permission_form.boy_scouts_activity
    @boy_scout = @boy_scouts_permission_form.boy_scouts_roster
    @user = User.find(@activity.user_id)

      if @boy_scouts_permission_form.status == "Submitted" || @boy_scouts_permission_form.status == "Updated"
        @boy_scouts_permission_form.status = "Updated"
      else
        @boy_scouts_permission_form.status = "Submitted"
      end

      if @boy_scouts_permission_form.save(:validate => false)
        Notifier.send_boy_scout_activity_consent_form_to_tl_notification(@activity, @boy_scout,@user).deliver
      end

  end

  def consumer_view_pdf
    @boy_scouts_permission_form = BoyScoutsActivityConsentForm.find(params[:id])
    @activity = @boy_scouts_permission_form.boy_scouts_activity
    @boy_scout = @boy_scouts_permission_form.boy_scouts_roster
    activity_name = @activity.activity_name.gsub(' ', '-') + '-activity-consent-form-of-id-' + @boy_scout.id.to_s + '-sp_id-' + @activity.service_provider_id.to_s
    permission_form_path = "#{PDFFILES_PATH}#{activity_name}.pdf"
      BoyScoutsActivityConsentForm.activity_parent_permission_form_pdf_generater(@activity, @boy_scouts_permission_form, permission_form_path)
   send_file permission_form_path,
              :filename => "#{activity_name}.pdf",
              :disposition => "inline",
              :type => "application/pdf"
  end

  def boy_scout_attending_val_change
    @boy_scouts_permission_form = BoyScoutsActivityConsentForm.find_by_id(params[:id])
    @boy_scouts_permission_form.attending = params[:selected_val]
    @boy_scouts_permission_form.save(:validate => false)
  end

end

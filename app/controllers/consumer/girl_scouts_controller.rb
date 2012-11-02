class Consumer::GirlScoutsController < ConsumerController

  def index
    session["consumer_tab_index"] = 4
    @results = []
    @girl_scouts_activity_permission_forms = current_user.girl_scouts_activity_permission_forms.order("updated_at DESC")
    @girl_scouts_activity_permission_forms.each do |pf|
      item = {}
      item[:id] = pf.id
      item[:girl_scout] = pf.girls_scout.first_name + ' ' + pf.girls_scout.last_name
      item[:activity_name] = pf.girl_scouts_activity.activity_name
      item[:activity_date_begin] = pf.girl_scouts_activity.activity_date_begin
      item[:activity_date_end] = pf.girl_scouts_activity.activity_date_end
      if !pf.girl_scouts_activity.activity_cost_cents.nil?
        item[:cents] = pf.girl_scouts_activity.activity_cost_cents <= 9 ? ('0' + pf.girl_scouts_activity.activity_cost_cents.to_s) : pf.girl_scouts_activity.activity_cost_cents.to_s
      else
        item[:cents] = '00'
      end
      item[:dollars] = pf.girl_scouts_activity.activity_cost_dollars.to_s
      item[:price] = item[:dollars] + '.' + item[:cents]
      item[:due_date] = pf.girl_scouts_activity.activity_signed_permission_due_date
      item[:girl_scout_attending] = pf.girl_scout_attending
      item[:status] = pf.status
      item[:updated_at] = pf.updated_at
      @results << item
    end
    render :layout => false if request.xhr?
  end

  def view_girl_scout_permission_form
    session["consumer_tab_index"] = 4
    @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find_by_id(params[:id])
    @activity = @girl_scouts_permission_form.girl_scouts_activity
    @girl_scout = @girl_scouts_permission_form.girls_scout
    if @girl_scouts_permission_form.status == "Submitted" || @girl_scouts_permission_form.status == "Updated"
      @girl_scouts_permission_form.status = "Submitted"
    else
      @girl_scouts_permission_form.status = 'In Progress'
    end
    @girl_scouts_permission_form.save()

    if !@activity.activity_cost_cents.nil?
      @cents = @activity.activity_cost_cents <= 9 ? ('0' + @activity.activity_cost_cents.to_s) : @activity.activity_cost_cents.to_s
    else
      @cents = '00'
    end
    @recent_submitted_form = current_user.girl_scouts_activity_permission_forms.where('status in (?) and girls_scout_id=?', ['Sent', 'Submitted', 'Updated'], @girl_scout.id).order('updated_at').last
    if @recent_submitted_form
      @girl_scouts_permission_form.attributes.each do |attr_name, attr_val|
        unless attr_val
          @girl_scouts_permission_form[attr_name] = @recent_submitted_form[attr_name]
        end
      end
    end
  end

  def girl_scouts_permission_form
    @girl_scouts_permission_forms = GirlScoutsActivityPermissionForm.find_by_id(params[:girl_scouts_activity_permission_form][:id])
    @girl_scouts_permission_forms.attributes = params[:girl_scouts_activity_permission_form]
    @girl_scouts_permission_forms.save(:validate => false)
  end

  def send_permission_form_to_troop_leader
    @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find(params[:id])
    @activity = @girl_scouts_permission_form.girl_scouts_activity
    @girl_scout = @girl_scouts_permission_form.girls_scout
    @user = User.find(@activity.user_id)
    if @girl_scouts_permission_form.invalid?
      flash[:error] = "Something wrong please try again."
    else
      #raise @girl_scouts_permission_form.status.to_yaml
      if @girl_scouts_permission_form.status == "Submitted" || @girl_scouts_permission_form.status == "Updated"
        @girl_scouts_permission_form.status = "Updated"
      else
        @girl_scouts_permission_form.status = "Submitted"
      end
      @girl_scouts_permission_form.attending = true
      if @girl_scouts_permission_form.save()
        Notifier.send_permission_form_to_tl_notification(@activity, @girl_scout,@user).deliver
      end
    end
  end

  def consumer_view_pdf
    @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find(params[:id])
    @activity = @girl_scouts_permission_form.girl_scouts_activity
    @girl_scout = @girl_scouts_permission_form.girls_scout
    activity_name = @activity.activity_name.gsub(' ', '-') + '-permission-form-of-id-' + @girl_scout.id.to_s + '-sp_id-' + @activity.service_provider_id.to_s
    permission_form_path = "#{PDFFILES_PATH}#{activity_name}.pdf"
    if @activity.service_provider_id == 2
      GirlScoutsActivityPermissionForm.activity_parent_permission_form_pdf_generater(@activity, @girl_scouts_permission_form, permission_form_path)
    elsif @activity.service_provider_id == 3
      GirlScoutsActivityPermissionForm.activity_parent_diamonds_permission_form_pdf_generater(@activity, @girl_scouts_permission_form, permission_form_path)
    else
    end
    send_file permission_form_path,
              :filename => "#{activity_name}.pdf",
              :disposition => "inline",
              :type => "application/pdf"
  end

  def girl_scout_attending_val_change
    @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find_by_id(params[:id])
    @girl_scouts_permission_form.girl_scout_attending = params[:selected_val]
    @girl_scouts_permission_form.save
  end
end

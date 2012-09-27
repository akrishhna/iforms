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
      item[:price] = pf.girl_scouts_activity.activity_cost_dollars.to_s + '.' + pf.girl_scouts_activity.activity_cost_cents.to_s
      item[:due_date] = pf.girl_scouts_activity.activity_signed_permission_due_date
      item[:attending] = pf.attending
      item[:status] = pf.status
      item[:updated_at] = pf.updated_at
      @results << item
    end
    render :layout => false if request.xhr?
  end

  def view_girl_scout_permission_form
    @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find_by_id(params[:id])
    @activity = @girl_scouts_permission_form.girl_scouts_activity
    @girl_scout = @girl_scouts_permission_form.girls_scout
    @girl_scouts_permission_form.status = 'In Progress'
    @girl_scouts_permission_form.save()
    @recent_submitted_form = current_user.girl_scouts_activity_permission_forms.where('status=?', 'Sent').order('updated_at').last
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
    if @girl_scouts_permission_form.invalid?
      flash[:error] = "Something wrong please try again."
    else
      @girl_scouts_permission_form.status = "Sent"
      @girl_scouts_permission_form.attending = true
      if @girl_scouts_permission_form.save()
        Notifier.send_permission_form_to_tl_notification(@activity, @girl_scout).deliver
      end
    end
  end

  def consumer_view_pdf
    @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find(params[:id])
    @activity = @girl_scouts_permission_form.girl_scouts_activity
    @girl_scout = @girl_scouts_permission_form.girls_scout
    activity_name = @activity.activity_name.gsub(' ', '-') + '-permission-form-of-id-' + @girl_scout.id.to_s
    permission_form_path = "#{PDFFILES_PATH}#{activity_name}.pdf"
    GirlScoutsActivityPermissionForm.activity_parent_permission_form_pdf_generater(@activity,@girl_scouts_permission_form,permission_form_path)
    permission_form_path = "#{PDFFILES_PATH}#{activity_name}.pdf" # ? "#{PDFFILES_PATH}#{alternate_activity_name}.pdf": ""
    send_file permission_form_path,
              :filename => "#{activity_name}.pdf", # ? "#{alternate_activity_name}.pdf":"",
              :disposition => "inline",
              :type => "application/pdf"
  end

  def girl_scout_attending_val_change
    @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find_by_id(params[:id])
    if @girl_scouts_permission_form.attending
    @girl_scouts_permission_form.attending = false
    else
      @girl_scouts_permission_form.attending = true
      end
    @girl_scouts_permission_form.save
  end
end

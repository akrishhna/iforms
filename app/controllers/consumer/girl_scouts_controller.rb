class Consumer::GirlScoutsController < ConsumerController

  def index
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
    @girl_scouts_permission_form.status = 'In Progress'
    @girl_scouts_permission_form.save()
    @activity = @girl_scouts_permission_form.girl_scouts_activity
    @girl_scout = @girl_scouts_permission_form.girls_scout
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
        Notifier.send_permission_form_to_tl_notification(@activity,@girl_scout).deliver
      end
    end
  end

end

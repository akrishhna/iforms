class Consumer::GirlScoutsController < ConsumerController

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

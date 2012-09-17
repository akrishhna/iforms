class ConsumerController < ApplicationController
  before_filter :set_service_provider

  def index
    @consumer_tab_index = session["consumer_tab_index"]
  end

  #Boy Scouts
  def boy_scouts_list
    session["consumer_tab_index"] = 0
    render :layout => false if request.xhr?
  end

  #Dental
  def dental_list
    session["consumer_tab_index"] = 1
    render :layout => false if request.xhr?
  end

  # Elementary School
  def elementary_school_list
    session["consumer_tab_index"] = 2
    render :layout => false if request.xhr?
  end

  # Florist
  def florist_list
    session["consumer_tab_index"] = 3
    render :layout => false if request.xhr?
  end

  #Girl Scouts
  def girl_scouts_list
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
      @results << item
    end
    render :layout => false if request.xhr?
  end

  #Medical
  def medical_list
    session["consumer_tab_index"] = 5
    render :layout => false if request.xhr?
  end

  #Pre School
  def pre_school_list
    session["consumer_tab_index"] = 6

    render :layout => false if request.xhr?
  end

  def view_girl_scout_permission_form
    @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find_by_id(params[:id])
    @girl_scouts_permission_form.status = 'In Progress'
    @girl_scouts_permission_form.attending = true
    @girl_scouts_permission_form.save()
    @activity = @girl_scouts_permission_form.girl_scouts_activity
  end

  def girl_scouts_permission_form
    @girl_scouts_permission_forms = GirlScoutsActivityPermissionForm.find_by_id(params[:girl_scouts_activity_permission_form][:id])
    @girl_scouts_permission_forms.attributes = params[:girl_scouts_activity_permission_form]
    @girl_scouts_permission_forms.save(:validate => false)
  end

  def send_permission_form_to_troop_leader
    @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find(params[:id])
    @activity = @girl_scouts_permission_form.girl_scouts_activity
    if @girl_scouts_permission_form.invalid?
      flash[:error] = "Something wrong please try again."
    else
      Notifier.send_permission_form_to_tl_notification(@activity).deliver
      @girl_scouts_permission_form.status = "Sent" + " " + Time.now.strftime("%m/%d/%Y")
      @girl_scouts_permission_form.save()
      #raise @pdftk.fields(form_pdf_path).to_yaml
    end
  end

  private

  def set_service_provider
    session[:user_service_provider] = 0
  end
end

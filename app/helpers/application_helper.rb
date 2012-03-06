module ApplicationHelper
  def javascript(url)
    content_for :javascript do
      javascript_include_tag url
    end
  end

  def page_action
    params[:controller].gsub('/', '-') + '_' + params[:action]
  end

  def page_controller
    params[:controller].gsub('/', '-')
  end

  def user_dashboard_url
    if page_controller.include?('admin')
      '/admin/dashboard'
    elsif page_controller.include?('doctor')
      '/doctor/dashboard'
    elsif page_controller.include?('patient')
      '/patient/dashboard'
    else
      '/home/user_roles'
    end
  end

  # devise
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end

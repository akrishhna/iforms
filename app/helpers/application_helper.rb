module ApplicationHelper
  def javascript(url)
    content_for :javascript do
      javascript_include_tag url
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def page_action
    params[:action]
  end

  def page_controller
    params[:controller].gsub('/', '-')
  end

end

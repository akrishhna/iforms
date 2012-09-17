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

  def page
    page_controller + "_" + page_action
  end

  # Render error messages for the given objects. The :message and :header_message options are allowed.
  def error_messages_for(*objects)
    options = objects.extract_options!
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    unless messages.empty?
      content_tag(:div, :class => "alert alert-block alert-error form_errors") do
        list_items = messages.map { |msg| content_tag(:li, msg) }
        concat content_tag(:a, raw('&times;'), :class => 'close', "data-dismiss" => 'alert')
        concat content_tag(:ul, list_items.join.html_safe)
      end
    end
  end

  module FormBuilderAdditions
    def error_messages(options = {})
      @template.error_messages_for(@object, options)
    end
  end

end

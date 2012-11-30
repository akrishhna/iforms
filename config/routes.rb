Iforms::Application.routes.draw do

  devise_scope :user do
    match '/registration/validate_users_sign_up_page' => 'registrations#validate_users_sign_up_page'
  end

  resources :girl_scout_troop_leader_profiles

  namespace :admin do
    resources :users do
      collection do
        get 'change_service_provider_status'
        get 'extend_service'
        post 'add_service'
        post 'extend_user_service'
      end
    end
  end

  resources :admin do
    collection do
      get 'admin_users'
      get 'change_admin_user_status'
      get 'delete_admin_user'
      post 'add_admin_user'
    end
  end

  resources :profiles

  get "errors/error_404"

  get "errors/error_500"

  namespace :consumer do
    resources :girl_scouts do
      collection do
        post 'girl_scout_attending_val_change'
        get 'consumer_view_pdf'
        post 'send_permission_form_to_troop_leader'
        post 'girl_scouts_permission_form'
        get 'view_girl_scout_permission_form'
        get 'index'
      end
    end
    resources :dental do
      collection do
        get 'index'
      end
    end
    resources :medical do
      collection do
        get 'index'
        get 'edit_medical_form'
      end
    end
  end

  resources :consumer do
    collection do
      get 'boy_scouts_list'
      get 'dental_list'
      get 'elementary_school_list'
      get 'florist_list'
      get 'girl_scouts_list'
      get 'medical_list'
      get 'pre_school_list'
    end
  end

  match 'girl_scouts_troop_leaders/activity_permission_form/:activity_id' => "girl_scouts_troop_leaders#activity_permission_form", :as => "activity_permission_form_pdf"
  match 'girl_scouts_troop_leaders/activity/:activity_id' => 'girl_scouts_troop_leaders#show_activity', :as => 'girl_scouts_activity'
  resources :girl_scouts_troop_leaders do
    collection do
      get 'show_all_permission_forms_pdf'
      get 'pdf_merging'
      get 'permission_forms'
      get 'activities'
      get 'roster'
      get 'get_girl_scouts_row'
      post 'girl_scouts_roster'
      post 'delete_girl_scouts'
      post 'create_activity'
      post 'send_notification_email'
      post 'delete_activity'
      post 'resend_permission_form'
      post 'change_welcome_message_status'
    end
  end

  get 'confirmations/new'

  get 'contactus/new'
  get 'contactus/index'
  resources :contactus

  get 'childforms/new'

  get 'childforms/show'

  get 'childforms/edit'

  get 'appointments/new'
  get 'appointments/index'


  get 'pdfuploads/index'
  get 'pdfuploads/new'
  get 'pdfuploads/show'

  get 'deviseroles/index'

  get 'doctors/new'
  get 'doctors/show'

  match 'patient/appointments' => 'patients#index' #, :as =>"patients/appointments"
  match 'appointments/show' => 'appointments#show', :via => :post
  match 'doctor/appointments' => 'doctors#index'

  get 'patients/new'

  resources :pdfuploads
  resources :doctors
  resources :forms
  resources :patients
  resources :appointments
  resources :deviseroles do
    collection do
      post 'contacts'
      get 'user_details'
      get 'forgot_username'
      post 'sending_username'
      post 'validate_girl_scout_sign_up_page'
    end
  end
  match 'girl_scouts/sign_up' => 'deviseroles#girl_scout_sign_up_page'
  match '/deviseroles/girl_scouts_sign_up' => 'deviseroles#girl_scout_sign_up'

  resources :childforms
  resources :iforms do
    collection do
      get 'get_iform'
      post 'iform_field_update'
      post 'iform_all_fields_update'
    end
  end

  devise_for :users, :path => 'users', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => ''}, :controllers => {:registrations => 'registrations', :confirmations => 'confirmations', :passwords => 'passwords'}

  match '/about', :to => 'deviseroles#about'
  match '/contact', :to => 'deviseroles#contact'
  match '/FAQ', :to => 'deviseroles#FAQ'
  match 'privacy_policy', :to => 'deviseroles#privacy_policy'
  root :to => redirect {|p, req| req.flash.keep; "/users/login"}

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', :to => 'errors#error_404'
  end

  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

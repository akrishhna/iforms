Iforms::Application.routes.draw do

  namespace :consumer do
    resources :girl_scouts do
      collection do
        post 'send_permission_form_to_troop_leader'
        post 'girl_scouts_permission_form'
        get 'view_girl_scout_permission_form'
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
      get 'activities'
      get 'roster'
      get 'get_girl_scouts_row'
      post 'girl_scouts_roster'
      post 'delete_girl_scouts'
      post 'create_activity'
      post 'send_notification_email'
      post 'delete_activity'
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

  get 'admin/index'
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
    end
  end
  resources :childforms
  resources :iforms do
    collection do
      get 'get_iform'
      post 'iform_field_update'
    end
  end

  devise_for :admins
  devise_for :users, :path => 'users', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => ''}, :controllers => {:registrations => 'registrations', :confirmations => 'confirmations'}

  match '/about', :to => 'deviseroles#about'
  match '/contact', :to => 'deviseroles#contact'
  match '/FAQ', :to => 'deviseroles#FAQ'
  match 'privacy_policy', :to => 'deviseroles#privacy_policy'
  root :to => redirect("/users/login")

  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

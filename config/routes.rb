Iforms::Application.routes.draw do

  resources :girl_scouts_troop_leaders do
    collection do
      get 'roster'
      get 'get_girl_scouts_row'
      post 'girl_scouts_roster'
      post 'delete_girl_scouts'
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

  match 'patient/appointments' => 'patients#index'#, :as =>"patients/appointments"
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
  devise_for :users, :path => 'users', :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => '' }, :controllers => {:registrations => 'registrations', :confirmations => 'confirmations'}

  match '/about', :to => 'deviseroles#about'
  match '/contact', :to => 'deviseroles#contact'
  match '/FAQ', :to => 'deviseroles#FAQ'
  match 'privacy_policy', :to => 'deviseroles#privacy_policy'
  root :to => redirect("/users/login")

  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

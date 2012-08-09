Iforms::Application.routes.draw do

  namespace :patient do

    resources :appointments
    resource :profile do
      collection do
        get 'change_password'
        post 'update_password'
      end
    end
    resource :dashboard do
      collection do
        get 'index'
      end
    end
  end

  namespace :doctor do

    resources :appointments
    resource :profile do
      collection do
        get 'change_password'
        post 'update_password'
      end
    end

    resource :dashboard do
      collection do
        get 'index'
      end
    end
  end

  namespace :admin do

    resources :forms
    resources :doctors

    resource :dashboard do
      collection do
        get 'index'
      end
    end
  end

  resource :home do
    collection do
      get 'index'
      get 'user_roles'
    end
  end

  root :to => 'home#index'

  #TODO old routes need remove which is un necessary after testing
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
    end
  end
  resources :childforms
  resources :iforms do
    collection do
      get 'get_iform'
      post 'iform_field_update'
    end
  end

  devise_for :users, :path => 'users', :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => '' }, :controllers => {:registrations => 'registrations', :confirmations => 'confirmations'}

  match '/about', :to => 'deviseroles#about'
  match '/contact', :to => 'deviseroles#contact'
  match '/FAQ', :to => 'deviseroles#FAQ'



  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

ActiveAdmin.register AdminUser do     
  index do
    column :username
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :username_or_email, :as => 'string'
  config.sort_order = 'username_asc'

  form do |f|                         
    f.inputs "Admin Details" do
      f.input :username
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.buttons                         
  end                                 
end                                   

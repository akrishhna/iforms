# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111106214124) do

  create_table "admins", :force => true do |t|
    t.string   "email",                             :default => "", :null => false
    t.string   "encrypted_password", :limit => 128, :default => "", :null => false
    t.string   "password_salt",                     :default => "", :null => false
    t.integer  "sign_in_count",                     :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                   :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appformjoins", :force => true do |t|
    t.integer  "appointment_id"
    t.integer  "form_id"
    t.integer  "iform_id"
    t.string   "formname"
    t.string   "status"
    t.datetime "formsubmittedtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.datetime "datetime"
    t.string   "doctorname"
    t.string   "formname"
    t.datetime "timesent"
    t.datetime "timereceived"
    t.string   "status"
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "controls", :force => true do |t|
    t.string   "name"
    t.string   "controltype"
    t.integer  "pdfupload_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", :force => true do |t|
    t.string   "doctorname"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", :force => true do |t|
    t.string   "formname"
    t.string   "formpath"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iforms", :force => true do |t|
    t.string   "Self_Email_Address",                                                           :limit => 50
    t.string   "Self_Name_First",                                                              :limit => 50
    t.string   "Self_Name_Honorific",                                                          :limit => 50
    t.string   "Self_Name_Middle",                                                             :limit => 50
    t.string   "Self_Prefix",                                                                  :limit => 50
    t.string   "Self_Name_Preferred",                                                          :limit => 50
    t.string   "Self_Sex",                                                                     :limit => 1
    t.integer  "Self_Age"
    t.string   "Self_Social_Security_Number",                                                  :limit => 10
    t.string   "Self_Home_Address1",                                                           :limit => 100
    t.string   "Self_Home_Address2",                                                           :limit => 100
    t.string   "Self_Home_City",                                                               :limit => 50
    t.string   "Self_Home_State",                                                              :limit => 25
    t.string   "Self_Home_Postal_Code",                                                        :limit => 10
    t.string   "Self_Marital_Status",                                                          :limit => 10
    t.string   "Self_Phone_Home",                                                              :limit => 15
    t.string   "Self_Phone_Mobile",                                                            :limit => 15
    t.string   "Self_Phone_Work",                                                              :limit => 15
    t.integer  "Self_Phone_Work_Extension",                                                    :limit => 10
    t.string   "Self_Driver_License_Number",                                                   :limit => 15
    t.string   "Self_Employer_Name",                                                           :limit => 25
    t.string   "Self_Employer_Address1",                                                       :limit => 50
    t.string   "Self_Employer_Address2",                                                       :limit => 50
    t.string   "Self_Employer_City",                                                           :limit => 20
    t.string   "Self_Employer_State",                                                          :limit => 20
    t.string   "Self_Employer_Postal_Code",                                                    :limit => 5
    t.string   "Self_Length_Of_Employment",                                                    :limit => 25
    t.string   "Self_Occupation",                                                              :limit => 50
    t.string   "Self_General_Dentist_Name",                                                    :limit => 50
    t.string   "Self_Referred_By",                                                             :limit => 50
    t.string   "Self_Other_Family_Members",                                                    :limit => 50
    t.string   "Self_Best_Contact_Method",                                                     :limit => 50
    t.time     "Self_Best_Contact_Time"
    t.date     "Todays_Date"
    t.date     "Self_Birthdate"
    t.date     "Self_General_Dentist_Date_Last_Appointment"
    t.string   "Spouse_Name_First",                                                            :limit => 50
    t.string   "Spouse_Name_Last",                                                             :limit => 50
    t.string   "Spouse_Employer_Name",                                                         :limit => 50
    t.string   "Spouse_Phone_Work",                                                            :limit => 10
    t.string   "Spouse_Social_Security_Number",                                                :limit => 10
    t.integer  "Spouse_Phone_Work_Extension"
    t.date     "Spouse_Birthdate"
    t.string   "Person_Responsible_For_Account_Name_First",                                    :limit => 50
    t.string   "Person_Responsible_For_Account_Name_Last",                                     :limit => 50
    t.string   "Person_Responsible_For_Account_Phone_Work",                                    :limit => 10
    t.integer  "Person_Responsible_For_Account_Phone_Work_Extension"
    t.string   "Person_Responsible_For_Account_Phone_Home",                                    :limit => 10
    t.string   "Person_Responsible_For_Account_Employer_Name",                                 :limit => 15
    t.string   "Person_Responsible_For_Account_Social_Security_Number",                        :limit => 10
    t.string   "Person_Responsible_For_Account_Address1",                                      :limit => 100
    t.string   "Person_Responsible_For_Account_Address2",                                      :limit => 100
    t.string   "Person_Responsible_For_Account_City",                                          :limit => 20
    t.string   "Person_Responsible_For_Account_State",                                         :limit => 20
    t.string   "Person_Responsible_For_Account_Postal_Code",                                   :limit => 20
    t.string   "Person_Responsible_For_Account_Relationship",                                  :limit => 50
    t.string   "Person_Responsible_For_Account_Drivers_License",                               :limit => 15
    t.boolean  "Insurance_Company_Primary_Orthodontic_Coverage"
    t.boolean  "Insurance_Company_Primary_Dental_Coverage"
    t.string   "Insurance_Company_Primary_Name",                                               :limit => 50
    t.string   "Insurance_Company_Primary_Address1",                                           :limit => 100
    t.string   "Insurance_Company_Primary_Address2",                                           :limit => 100
    t.string   "Insurance_Company_Primary_City",                                               :limit => 20
    t.string   "Insurance_Company_Primary_State",                                              :limit => 20
    t.string   "Insurance_Company_Primary_Postal_Code",                                        :limit => 5
    t.string   "Insurance_Company_Primary_Phone",                                              :limit => 10
    t.string   "Insurance_Company_Primary_Group_Plan_Local_Policy_Number",                     :limit => 50
    t.string   "Insurance_Company_Primary_Insured_Name_First",                                 :limit => 50
    t.string   "Insurance_Company_Primary_Insured_Name_Last",                                  :limit => 50
    t.string   "Insurance_Company_Primary_Insured_Relationship",                               :limit => 20
    t.date     "Insurance_Company_Primary_Insured_Birthdate"
    t.string   "Insurance_Company_Primary_Insured_Social_Security_Number",                     :limit => 10
    t.string   "Insurance_Company_Primary_Insured_Employer_Name",                              :limit => 50
    t.boolean  "Insurance_Company_Secondary_Orthodontic_Coverage"
    t.boolean  "Insurance_Company_Secondary_Dental_Coverage"
    t.string   "Insurance_Company_Secondary_Name",                                             :limit => 50
    t.string   "Insurance_Company_Secondary_Address1",                                         :limit => 100
    t.string   "Insurance_Company_Secondary_Address2",                                         :limit => 100
    t.string   "Insurance_Company_Secondary_City",                                             :limit => 20
    t.string   "Insurance_Company_Secondary_State",                                            :limit => 20
    t.string   "Insurance_Company_Secondary_Postal_Code",                                      :limit => 5
    t.string   "Insurance_Company_Secondary_Phone",                                            :limit => 10
    t.string   "Insurance_Company_Secondary_Group_Plan_Local_Policy_Number",                   :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Name_First",                               :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Name_Last",                                :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Relationship",                             :limit => 50
    t.date     "Insurance_Company_Secondary_Insured_Birthdate"
    t.string   "Insurance_Company_Secondary_Insured_Social_Security_Number",                   :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Employer_Name",                            :limit => 50
    t.string   "Emergency_Contact_Name_First",                                                 :limit => 50
    t.string   "Emergency_Contact_Name_Last",                                                  :limit => 50
    t.string   "Emergency_Contact_Relationship",                                               :limit => 50
    t.string   "Emergency_Contact_Phone_Work",                                                 :limit => 15
    t.string   "Emergency_Contact_Phone_Home",                                                 :limit => 15
    t.boolean  "Medical_History_Do_You_Have_Personal_Physician"
    t.string   "Medical_History_Personal_Physician_Name_First",                                :limit => 50
    t.string   "Medical_History_Personal_Physician_Name_Last",                                 :limit => 50
    t.string   "Medical_History_Personal_Physician_Phone",                                     :limit => 15
    t.date     "Medical_History_Personal_Physician_Date_Of_Last_Visit"
    t.string   "Medical_History_Current_Physical_Health",                                      :limit => 5
    t.boolean  "Medical_History_Currently_Under_The_Care_Of_A_Physician"
    t.string   "Medical_History_Currently_Under_The_Care_Of_A_Physician_Description"
    t.boolean  "Medical_History_Currently_Taking_Prescription_Or_Over_The_Counter_Drugs"
    t.string   "Medical_History_Currently_Taking_Prescription_Or_Over_The_Counter_Drugs_List"
    t.boolean  "Medical_History_Currently_Taking_Birth_Control_Pills"
    t.boolean  "Medical_History_Currently_Pregnant"
    t.string   "Medical_History_Weeks_Pregnant",                                               :limit => 20
    t.boolean  "Medical_History_Currently_Nursing"
    t.boolean  "Medical_History_Abnormal_Bleeding"
    t.boolean  "Medical_History_Anemia"
    t.boolean  "Medical_History_Artificial_Bones_Joints_Valves"
    t.boolean  "Medical_History_Asthma"
    t.boolean  "Medical_History_Blood_Transfusion"
    t.boolean  "Medical_History_Cancer"
    t.boolean  "Medical_History_Congenital_Heart_Defect"
    t.boolean  "Medical_History_Diabetes"
    t.boolean  "Medical_History_Difficulty_Breathing"
    t.boolean  "Medical_History_Drug_Abuse"
    t.boolean  "Medical_History_Emphysema"
    t.boolean  "Medical_History_Epilepsy"
    t.boolean  "Medical_History_Fever_Blisters"
    t.boolean  "Medical_History_Glaucoma"
    t.boolean  "Medical_History_Heart_Attack_Or_Stroke"
    t.boolean  "Medical_History_Heart_Murmur"
    t.boolean  "Medical_History_Heart_Surgery_Or_Pacemaker"
    t.boolean  "Medical_History_Hemophilia"
    t.boolean  "Medical_History_Hepatitis"
    t.boolean  "Medical_History_High_Or_Low_Blood_Pressure"
    t.boolean  "Medical_History_AIDS"
    t.boolean  "Medical_History_Hospitalized_For_Any_Reason"
    t.boolean  "Medical_History_Kidney_Problems"
    t.boolean  "Medical_History_Mitral_Valve_Prolapse"
    t.boolean  "Medical_History_Psychiatric_Problems"
    t.boolean  "Medical_History_Radiation_Treatment"
    t.boolean  "Medical_History_Rheumatic_Fever_Or_Scarletfever"
    t.boolean  "Medical_History_Frequent_Headaches"
    t.boolean  "Medical_History_Shingles"
    t.boolean  "Medical_History_Sickle_Cell_Disease_Or_Traits"
    t.boolean  "Medical_History_Sinus_Problems"
    t.boolean  "Medical_History_Tuberculosis"
    t.boolean  "Medical_History_Ulcers"
    t.boolean  "Medical_History_Venereal_Disease"
    t.string   "Medical_History_Serious_Medical_Issues"
    t.boolean  "Allergic_To_Aspirin"
    t.boolean  "Allergic_To_Metals_Or_Plastics"
    t.boolean  "Allergic_To_Codeine"
    t.boolean  "Allergic_To_Dental_Anesthetics"
    t.boolean  "Allergic_To_Erythromycin"
    t.boolean  "Allergic_To_Latex"
    t.boolean  "Allergic_To_Penicillin"
    t.boolean  "Allergic_To_Tetracycline"
    t.boolean  "Allergic_To_Other"
    t.string   "Allergic_To_Other_Detail"
    t.string   "Dental_History_Concerns_Tobe_Accomplished_By_Orthodontics"
    t.boolean  "Dental_History_Previous_Orthodontic_Evaluation"
    t.boolean  "Dental_History_Previous_Dental_Work_Issues"
    t.boolean  "Dental_History_TMJ_TMD_Issues"
    t.string   "Dental_History_Current_Dental_Health",                                         :limit => 5
    t.string   "Dental_History_Injury_To_Chin",                                                :limit => 6
    t.string   "Dental_History_Injury_To_Teeth",                                               :limit => 6
    t.string   "Dental_History_Injury_To_Mouth",                                               :limit => 6
    t.boolean  "Dental_History_Like_Smile"
    t.boolean  "Dental_History_Bleeding_Gums"
    t.boolean  "Dental_History_Currently_Have_Speech_Problems"
    t.boolean  "Dental_History_Breath_Through_Mouth"
    t.string   "Dental_History_Breath_Through_Mouth_While_Awake",                              :limit => 10
    t.string   "Dental_History_Breath_Through_Mouth_While_Sleep",                              :limit => 10
    t.boolean  "Dental_History_Any_Extra_Permanent_Teeth"
    t.boolean  "Dental_History_Ever_Taken_PhenFen_Redux_Pondimin"
    t.string   "Dental_History_When_Taken_PhenFen_Redux_Pondimin",                             :limit => 50
    t.boolean  "Dental_History_Tobacco_Smoke"
    t.string   "path"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pdfuploads", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121231094740) do

  create_table "admin_users", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "status",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "appformjoins", :force => true do |t|
    t.integer  "appointment_id"
    t.integer  "form_id"
    t.integer  "iform_id"
    t.integer  "childform_id"
    t.integer  "patient_user_id"
    t.integer  "doctor_user_id"
    t.string   "formname"
    t.string   "status"
    t.datetime "formsubmittedtime"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "appointments", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.date     "date"
    t.string   "time_hrs"
    t.string   "time_min"
    t.string   "AM_PM"
    t.string   "doctorname"
    t.string   "formname"
    t.string   "timesent"
    t.string   "timereceived"
    t.string   "status"
    t.string   "appointment_time"
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "location"
    t.string   "responsible_party"
    t.string   "preferred_name"
    t.integer  "service_provider_id"
    t.integer  "doctor_user_id"
    t.integer  "patient_user_id"
    t.string   "appointment_doctor_name", :limit => 50
  end

  create_table "boy_scouts_activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "service_provider_id"
    t.string   "activity_name"
    t.date     "activity_date_begin"
    t.date     "activity_date_end"
    t.date     "activity_signed_permission_due_date"
    t.string   "leader_first_name"
    t.string   "leader_last_name"
    t.string   "leader_email"
    t.integer  "leader_phone_1"
    t.integer  "leader_phone_2"
    t.integer  "leader_phone_3"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "boy_scouts_activity_consent_forms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "boy_scouts_roster_id"
    t.integer  "boy_scouts_activity_id"
    t.string   "attending"
    t.string   "status"
    t.string   "bacf_restriction"
    t.string   "bacf_spcl_considerations_for_restriction"
    t.date     "bacf_birthdate"
    t.string   "bacf_address_1"
    t.string   "bacf_address_2"
    t.string   "bacf_address_city"
    t.string   "bacf_address_state"
    t.string   "bacf_address_zip"
    t.string   "bacf_parent_first_name"
    t.string   "bacf_parent_last_name"
    t.integer  "bacf_parent_phone_1"
    t.integer  "bacf_parent_phone_2"
    t.integer  "bacf_parent_phone_3"
    t.string   "email"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "boy_scouts_rosters", :force => true do |t|
    t.integer  "user_id"
    t.integer  "service_provider_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "parent_first_name"
    t.string   "parent_last_name"
    t.string   "email"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "childforms", :force => true do |t|
    t.boolean  "Accompanying_Your_Child_Today_Has_Legal_Custody_Of_Child"
    t.string   "Accompanying_Your_Child_Today_Relationship",                      :limit => 20
    t.string   "Accompanying_Your_Child_Today_Siblings_And_Ages",                 :limit => 100
    t.string   "Accompanying_Your_Child_Today_Name_First",                        :limit => 50
    t.string   "Accompanying_Your_Child_Today_Name_Last",                         :limit => 50
    t.boolean  "Allergic_To_Any_Drugs"
    t.string   "Allergic_To_Any_Drugs_List",                                      :limit => 100
    t.boolean  "Allergic_To_Latex"
    t.boolean  "Allergic_To_Metals"
    t.boolean  "Allergic_To_Plastics"
    t.date     "Date_Time_Form_Submitted_By_Consumer_To_Service_Provider"
    t.boolean  "Dental_History_Any_Extra_Permanent_Teeth"
    t.boolean  "Dental_History_Any_Missing_Teeth"
    t.boolean  "Dental_History_Brush_Teeth_Daily"
    t.boolean  "Dental_History_Floss_Teeth_Daily"
    t.boolean  "Dental_History_Injury_To_Chin"
    t.boolean  "Dental_History_Injury_To_Face"
    t.boolean  "Dental_History_Injury_To_Mouth"
    t.boolean  "Dental_History_Injury_To_Teeth"
    t.string   "Dental_History_Orthodontic_Goals"
    t.string   "Dental_History_Play_Musical_Instruments",                         :limit => 100
    t.boolean  "Dental_History_Previous_Orthodontic_Evaluation"
    t.boolean  "Dental_History_Previous_Orthodontic_Treatment"
    t.boolean  "Dental_History_TMJ_TMD_Issues_Current"
    t.boolean  "Dental_History_TMJ_TMD_Issues_Previous"
    t.boolean  "Dental_History_Tonsils_Removed"
    t.string   "Father_Drivers_License_Number",                                   :limit => 10
    t.string   "Father_Drivers_License_State",                                    :limit => 15
    t.string   "Father_Employer_Name",                                            :limit => 50
    t.string   "Father_Job_Title",                                                :limit => 50
    t.string   "Father_Length_Of_Employment",                                     :limit => 20
    t.string   "Father_Name_First",                                               :limit => 50
    t.string   "Father_Name_Last",                                                :limit => 50
    t.string   "Father_Name_Middle",                                              :limit => 50
    t.string   "Father_Phone_Home",                                               :limit => 10
    t.date     "Father_Birthdate"
    t.string   "Father_Phone_Work",                                               :limit => 10
    t.integer  "Father_Phone_Work_Extension"
    t.string   "Father_Social_Security_Number",                                   :limit => 10
    t.string   "Father_Stepfather_Or_Gaurdian",                                   :limit => 10
    t.boolean  "Habits_Bottle"
    t.boolean  "Habits_Breast_Fed"
    t.boolean  "Habits_Clenching_Or_Grinding_Teeth"
    t.boolean  "Habits_Lip_Sucking_Or_Biting"
    t.boolean  "Habits_Mouth_Breather"
    t.boolean  "Habits_Nail_Biting"
    t.boolean  "Habits_Nursing"
    t.boolean  "Habits_Speech_Problems"
    t.boolean  "Habits_Thumb_Or_Finger_Sucking"
    t.boolean  "Habits_Tongue_Thrust"
    t.string   "Insurance_Company_Primary_Address1",                              :limit => 100
    t.string   "Insurance_Company_Primary_Address2",                              :limit => 100
    t.string   "Insurance_Company_Primary_City",                                  :limit => 20
    t.boolean  "Insurance_Company_Primary_Dental_Coverage"
    t.string   "Insurance_Company_Primary_Group_Plan_Local_Policy_Number",        :limit => 50
    t.date     "Insurance_Company_Primary_Insured_Birthdate"
    t.string   "Insurance_Company_Primary_Insured_Employer_Name",                 :limit => 50
    t.string   "Insurance_Company_Primary_Insured_Name_First",                    :limit => 50
    t.string   "Insurance_Company_Primary_Insured_Name_Last",                     :limit => 50
    t.string   "Insurance_Company_Primary_Insured_Relationship",                  :limit => 20
    t.string   "Insurance_Company_Primary_Insured_Social_Security_Number",        :limit => 10
    t.string   "Insurance_Company_Primary_Name",                                  :limit => 50
    t.boolean  "Insurance_Company_Primary_Orthodontic_Coverage"
    t.string   "Insurance_Company_Primary_Phone",                                 :limit => 10
    t.string   "Insurance_Company_Primary_Postal_Code",                           :limit => 5
    t.string   "Insurance_Company_Primary_State",                                 :limit => 15
    t.string   "Insurance_Company_Secondary_Address1",                            :limit => 100
    t.string   "Insurance_Company_Secondary_Address2",                            :limit => 100
    t.string   "Insurance_Company_Secondary_City",                                :limit => 20
    t.boolean  "Insurance_Company_Secondary_Dental_Coverage"
    t.string   "Insurance_Company_Secondary_Group_Plan_Local_Policy_Number",      :limit => 50
    t.date     "Insurance_Company_Secondary_Insured_Birthdate"
    t.string   "Insurance_Company_Secondary_Insured_Employer_Name",               :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Name_First",                  :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Name_Last",                   :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Relationship",                :limit => 20
    t.string   "Insurance_Company_Secondary_Insured_Social_Security_Number",      :limit => 10
    t.string   "Insurance_Company_Secondary_Name",                                :limit => 50
    t.boolean  "Insurance_Company_Secondary_Orthodontic_Coverage"
    t.string   "Insurance_Company_Secondary_Phone",                               :limit => 10
    t.string   "Insurance_Company_Secondary_Postal_Code",                         :limit => 5
    t.string   "Insurance_Company_Secondary_State",                               :limit => 15
    t.boolean  "Med_His_Abnormal_Bleeding"
    t.boolean  "Med_His_ADD"
    t.boolean  "Med_His_ADHD"
    t.boolean  "Med_His_AIDS"
    t.boolean  "Med_His_Any_Operations"
    t.boolean  "Med_His_Artificial_Bones_Joints_Valves"
    t.boolean  "Med_His_Asthma"
    t.boolean  "Med_His_Cancer"
    t.boolean  "Med_His_Congenital_Heart_Defect"
    t.boolean  "Med_His_Current_Physical_Health"
    t.string   "Med_His_Currently_Taking_Over_The_Counter_Drugs_List",            :limit => 100
    t.string   "Med_His_Currently_Taking_Presc_Drugs_List",                       :limit => 100
    t.boolean  "Med_His_Currently_Under_The_Care_Of_A_Physician"
    t.boolean  "Med_His_Diabetes"
    t.boolean  "Med_His_Epilepsy"
    t.boolean  "Med_His_Handicaps_Or_Disabilities"
    t.boolean  "Med_His_Hearing_Impairment"
    t.boolean  "Med_His_Heart_Murmur"
    t.boolean  "Med_His_Hemophilia"
    t.boolean  "Med_His_Hepatitis"
    t.boolean  "Med_His_HIV_Positive"
    t.boolean  "Med_His_Hospitalized_For_Any_Reason"
    t.boolean  "Med_His_Kidney_Problems"
    t.boolean  "Med_His_Liver_Problems"
    t.boolean  "Med_His_Lupus"
    t.string   "Med_His_Medical_Problems"
    t.boolean  "Med_His_Menstruation_Begun"
    t.date     "Med_His_Personal_Physician_Date_Of_Last_Visit"
    t.string   "Med_His_Personal_Physician_Name_First"
    t.string   "Med_His_Personal_Physician_Name_Last"
    t.string   "Med_His_Personal_Physician_Phone"
    t.boolean  "Med_His_Puberty_Begun"
    t.boolean  "Med_His_Rheumatic_Fever"
    t.boolean  "Med_His_Scarlet_Fever"
    t.boolean  "Med_His_Sickle_Cell_Disease"
    t.boolean  "Med_His_Sickle_Cell_Disease_Traits"
    t.boolean  "Med_His_Tuberculosis"
    t.string   "Mother_Drivers_License_Number",                                   :limit => 15
    t.string   "Mother_Drivers_License_State",                                    :limit => 15
    t.string   "Mother_Employer_Name",                                            :limit => 50
    t.string   "Mother_Job_Title",                                                :limit => 30
    t.string   "Mother_Length_Of_Employment",                                     :limit => 20
    t.string   "Mother_Name_First",                                               :limit => 50
    t.string   "Mother_Name_Last",                                                :limit => 50
    t.string   "Mother_Name_Middle",                                              :limit => 50
    t.date     "Mother_Birthdate"
    t.string   "Mother_Phone_Home",                                               :limit => 10
    t.string   "Mother_Phone_Work",                                               :limit => 10
    t.string   "Mother_Phone_Work_Extension"
    t.string   "Mother_Social_Security_Number",                                   :limit => 10
    t.string   "Mother_Stepmother_Or_Gaurdian",                                   :limit => 10
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Address1",               :limit => 100
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Address2",               :limit => 100
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_City",                   :limit => 20
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Name_First",             :limit => 50
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Name_Last",              :limit => 50
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Name_Middle",            :limit => 50
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Phone",                  :limit => 10
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Postal_Code",            :limit => 5
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_State",                  :limit => 15
    t.string   "Person_Responsible_For_Account_Address1",                         :limit => 100
    t.string   "Person_Responsible_For_Account_Address2",                         :limit => 100
    t.string   "Person_Responsible_For_Account_City",                             :limit => 20
    t.string   "Person_Responsible_For_Account_Drivers_License_Number",           :limit => 15
    t.string   "Person_Responsible_For_Account_Drivers_License_State",            :limit => 15
    t.string   "Person_Responsible_For_Account_Employer_Name",                    :limit => 50
    t.string   "Person_Responsible_For_Account_Name_First",                       :limit => 50
    t.string   "Person_Responsible_For_Account_Name_Last",                        :limit => 50
    t.string   "Person_Responsible_For_Account_Name_Middle",                      :limit => 50
    t.string   "Person_Responsible_For_Account_Payment_Method",                   :limit => 15
    t.string   "Person_Responsible_For_Account_Phone_Home",                       :limit => 10
    t.string   "Person_Responsible_For_Account_Phone_Work",                       :limit => 10
    t.integer  "Person_Responsible_For_Account_Phone_Work_Extension"
    t.string   "Person_Responsible_For_Account_Postal_Code",                      :limit => 5
    t.string   "Person_Responsible_For_Account_Previous_Address1",                :limit => 100
    t.string   "Person_Responsible_For_Account_Previous_Address2",                :limit => 100
    t.string   "Person_Responsible_For_Account_Previous_City",                    :limit => 20
    t.string   "Person_Responsible_For_Account_Previous_Postal_Code",             :limit => 5
    t.string   "Person_Responsible_For_Account_Previous_State",                   :limit => 15
    t.string   "Person_Responsible_For_Account_Relationship",                     :limit => 20
    t.string   "Person_Responsible_For_Account_Social_Security_Number",           :limit => 10
    t.string   "Person_Responsible_For_Account_State",                            :limit => 15
    t.string   "Person_Responsible_For_Making_Appointments_Name_First",           :limit => 50
    t.string   "Person_Responsible_For_Making_Appointments_Name_Last",            :limit => 50
    t.string   "Person_Responsible_For_Making_Appointments_Name_Middle",          :limit => 50
    t.string   "Person_Responsible_For_Making_Appointments_Phone_Home",           :limit => 10
    t.string   "Person_Responsible_For_Making_Appointments_Phone_Work",           :limit => 10
    t.integer  "Person_Responsible_For_Making_Appointments_Phone_Work_Extension"
    t.date     "Self_Birthdate"
    t.string   "Self_Email_Address",                                              :limit => 100
    t.date     "Self_General_Dentist_Date_Last_Appointment"
    t.string   "Self_General_Dentist_Name",                                       :limit => 50
    t.string   "Self_Grade",                                                      :limit => 20
    t.string   "Self_Hobbies",                                                    :limit => 100
    t.string   "Self_Home_Address1",                                              :limit => 100
    t.string   "Self_Home_Address2",                                              :limit => 100
    t.string   "Self_Home_City",                                                  :limit => 20
    t.string   "Self_Home_Postal_Code",                                           :limit => 5
    t.string   "Self_Home_State",                                                 :limit => 15
    t.string   "Self_Marital_Status",                                             :limit => 10
    t.string   "Self_Name_First",                                                 :limit => 50
    t.string   "Self_Name_Last",                                                  :limit => 50
    t.string   "Self_Name_Middle",                                                :limit => 50
    t.string   "Self_Name_Preferred",                                             :limit => 50
    t.string   "Self_Phone_Home",                                                 :limit => 10
    t.string   "Self_Referred_By",                                                :limit => 20
    t.string   "Self_School",                                                     :limit => 50
    t.string   "Self_Sex",                                                        :limit => 6
    t.string   "Self_Social_Security_Number",                                     :limit => 10
    t.string   "path"
    t.string   "formname",                                                        :limit => 50
    t.integer  "appointment_id"
    t.datetime "created_at",                                                                     :null => false
    t.datetime "updated_at",                                                                     :null => false
  end

  create_table "contactus", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "controls", :force => true do |t|
    t.string   "name"
    t.string   "controltype"
    t.integer  "pdfupload_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "display_messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "message_type"
    t.boolean  "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "doctors", :force => true do |t|
    t.string   "doctorname"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "service_provider_id"
  end

  create_table "forms", :force => true do |t|
    t.string   "formname"
    t.string   "formpath"
    t.integer  "doctor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "girl_scout_troop_leader_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "council_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "girl_scouts_activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "activity_name"
    t.string   "activity_location"
    t.date     "activity_date_begin"
    t.date     "activity_date_end"
    t.date     "activity_signed_permission_due_date"
    t.string   "activity_leave_from"
    t.integer  "activity_leave_time_hh"
    t.integer  "activity_leave_time_mm"
    t.string   "activity_leave_time_am_pm"
    t.string   "activity_return_to"
    t.integer  "activity_return_time_hh"
    t.integer  "activity_return_time_mm"
    t.string   "activity_return_time_am_pm"
    t.integer  "activity_cost_dollars"
    t.integer  "activity_cost_cents"
    t.boolean  "girls_wear_checkbox"
    t.string   "activity_girls_wear_others"
    t.string   "activity_girls_bring"
    t.string   "activity_equipment"
    t.string   "troop_service_unit"
    t.string   "troop_pal"
    t.string   "troop_number"
    t.string   "leader_first_name"
    t.string   "leader_last_name"
    t.string   "leader_email"
    t.integer  "leader_day_phone_1"
    t.integer  "leader_day_phone_2"
    t.integer  "leader_day_phone_3"
    t.integer  "leader_evening_phone_1"
    t.integer  "leader_evening_phone_2"
    t.integer  "leader_evening_phone_3"
    t.integer  "leader_cell_phone_1"
    t.integer  "leader_cell_phone_2"
    t.integer  "leader_cell_phone_3"
    t.string   "emergency_first_name"
    t.string   "emergency_last_name"
    t.integer  "emergency_day_phone_1"
    t.integer  "emergency_day_phone_2"
    t.integer  "emergency_day_phone_3"
    t.integer  "emergency_evening_phone_1"
    t.integer  "emergency_evening_phone_2"
    t.integer  "emergency_evening_phone_3"
    t.text     "email_notification"
    t.boolean  "status"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.integer  "service_provider_id"
    t.string   "mode_of_transportation"
    t.string   "leader_advisor_1_first_name"
    t.string   "leader_advisor_1_last_name"
    t.integer  "leader_advisor_1_phone_1"
    t.integer  "leader_advisor_1_phone_2"
    t.integer  "leader_advisor_1_phone_3"
    t.integer  "leader_advisor_1_cell_1"
    t.integer  "leader_advisor_1_cell_2"
    t.integer  "leader_advisor_1_cell_3"
    t.string   "leader_advisor_2_first_name"
    t.string   "leader_advisor_2_last_name"
    t.integer  "leader_advisor_2_phone_1"
    t.integer  "leader_advisor_2_phone_2"
    t.integer  "leader_advisor_2_phone_3"
    t.integer  "leader_advisor_2_cell_1"
    t.integer  "leader_advisor_2_cell_2"
    t.integer  "leader_advisor_2_cell_3"
    t.string   "troop_leader_emergency_contact_first_name"
    t.string   "troop_leader_emergency_contact_last_name"
    t.integer  "troop_leader_emergency_contact_phone_number_1"
    t.integer  "troop_leader_emergency_contact_phone_number_2"
    t.integer  "troop_leader_emergency_contact_phone_number_3"
    t.integer  "troop_leader_emergency_contact_cell_number_1"
    t.integer  "troop_leader_emergency_contact_cell_number_2"
    t.integer  "troop_leader_emergency_contact_cell_number_3"
    t.string   "troop_leader_emergency_contact_name_address_street"
    t.string   "troop_leader_emergency_contact_name_address_line"
    t.string   "troop_leader_emergency_contact_name_address_city"
    t.string   "troop_leader_emergency_contact_name_address_state"
    t.string   "troop_leader_emergency_contact_name_address_country"
    t.string   "troop_leader_emergency_contact_name_address_zip"
    t.string   "form_name",                                           :limit => 50
    t.string   "date_received",                                       :limit => 50
    t.string   "date_submitted",                                      :limit => 50
    t.string   "attending",                                           :limit => 50
    t.string   "program_year",                                        :limit => 50
    t.integer  "activity_time_hh"
    t.integer  "activity_time_mm"
    t.string   "activity_time_am_pm"
    t.string   "adults_accompanying_girls"
    t.integer  "activity_location_phone_1"
    t.integer  "activity_location_phone_2"
    t.integer  "activity_location_phone_3"
    t.integer  "troop_leader_phone_1"
    t.integer  "troop_leader_phone_2"
    t.integer  "troop_leader_phone_3"
    t.integer  "activity_start_time_hh"
    t.integer  "activity_start_time_mm"
    t.string   "activity_start_time_am_pm"
    t.integer  "activity_end_time_hh"
    t.integer  "activity_end_time_mm"
    t.string   "activity_end_time_am_pm"
    t.string   "activity_cost_used_for"
    t.string   "activity_will_involve_unusual_risk"
  end

  create_table "girl_scouts_activity_permission_forms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "girls_scout_id"
    t.integer  "girl_scouts_activity_id"
    t.boolean  "attending"
    t.string   "status"
    t.string   "gapf_girl_scouts_first_name"
    t.string   "gapf_girl_scouts_last_name"
    t.string   "gapf_emergency_contact_1_first_name"
    t.string   "gapf_emergency_contact_1_last_name"
    t.string   "gapf_emergency_contact_1_phone_1_1"
    t.string   "gapf_emergency_contact_1_phone_1_2"
    t.string   "gapf_emergency_contact_1_phone_1_3"
    t.string   "gapf_emergency_contact_1_phone_2_1"
    t.string   "gapf_emergency_contact_1_phone_2_2"
    t.string   "gapf_emergency_contact_1_phone_2_3"
    t.string   "gapf_emergency_contact_2_first_name"
    t.string   "gapf_emergency_contact_2_last_name"
    t.string   "gapf_emergency_contact_2_phone_1_1"
    t.string   "gapf_emergency_contact_2_phone_1_2"
    t.string   "gapf_emergency_contact_2_phone_1_3"
    t.string   "gapf_emergency_contact_2_phone_2_1"
    t.string   "gapf_emergency_contact_2_phone_2_2"
    t.string   "gapf_emergency_contact_2_phone_2_3"
    t.string   "gapf_emergency_contact_3_first_name"
    t.string   "gapf_emergency_contact_3_last_name"
    t.string   "gapf_emergency_contact_3_phone_1_1"
    t.string   "gapf_emergency_contact_3_phone_1_2"
    t.string   "gapf_emergency_contact_3_phone_1_3"
    t.string   "gapf_emergency_contact_3_phone_2_1"
    t.string   "gapf_emergency_contact_3_phone_2_2"
    t.string   "gapf_emergency_contact_3_phone_2_3"
    t.string   "gapf_physician_first_name"
    t.string   "gapf_physician_last_name"
    t.string   "gapf_physician_phone_1"
    t.string   "gapf_physician_phone_2"
    t.string   "gapf_physician_phone_3"
    t.string   "gapf_my_insurance_carrier"
    t.string   "gapf_policy"
    t.text     "gapf_special_needs"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.string   "girl_scout_attending"
    t.string   "daughter_first_name"
    t.string   "daughter_last_name"
    t.string   "act_in_my_behalf_first_name"
    t.string   "act_in_my_behalf_last_name"
    t.integer  "parent_phone_number_during_activity_1"
    t.integer  "parent_phone_number_during_activity_2"
    t.integer  "parent_phone_number_during_activity_3"
    t.string   "emergency_contact_first_name"
    t.string   "emergency_contact_last_name"
    t.integer  "emergency_contact_phone_number_1"
    t.integer  "emergency_contact_phone_number_2"
    t.integer  "emergency_contact_phone_number_3"
    t.integer  "emergency_contact_cell_number_1"
    t.integer  "emergency_contact_cell_number_2"
    t.integer  "emergency_contact_cell_number_3"
    t.string   "emergency_contact_address_street"
    t.string   "emergency_contact_address_line"
    t.string   "emergency_contact_address_city"
    t.string   "emergency_contact_address_state"
    t.string   "emergency_contact_address_country"
    t.integer  "emergency_contact_address_zip"
    t.string   "emergency_contact_relationship_to_participant"
    t.text     "medications"
    t.string   "act_in_my_behalf_address_1"
    t.string   "act_in_my_behalf_address_2"
    t.string   "act_in_my_behalf_address_city"
    t.string   "act_in_my_behalf_address_state"
    t.string   "act_in_my_behalf_address_zip"
    t.text     "gapf_changes_to_general_permission_slip"
    t.string   "gapf_special_needs_yes_or_no",                  :limit => 10
    t.string   "gapf_unusual_risk_acknowledgement",             :limit => 10
    t.string   "gapf_parent_1_address_1",                       :limit => 50
    t.string   "gapf_parent_1_address_2",                       :limit => 50
    t.string   "gapf_parent_1_address_city",                    :limit => 50
    t.string   "gapf_parent_1_address_state",                   :limit => 50
    t.integer  "gapf_parent_1_address_zip"
    t.integer  "gapf_parent_1_home_phone_1"
    t.integer  "gapf_parent_1_home_phone_2"
    t.integer  "gapf_parent_1_home_phone_3"
    t.integer  "gapf_parent_1_work_phone_1"
    t.integer  "gapf_parent_1_work_phone_2"
    t.integer  "gapf_parent_1_work_phone_3"
    t.integer  "gapf_parent_1_mobile_phone_1"
    t.integer  "gapf_parent_1_mobile_phone_2"
    t.integer  "gapf_parent_1_mobile_phone_3"
    t.integer  "gapf_parent_1_other_phone_1"
    t.integer  "gapf_parent_1_other_phone_2"
    t.integer  "gapf_parent_1_other_phone_3"
    t.string   "gapf_parent_1_email",                           :limit => 50
    t.string   "gapf_parent_2_address_1",                       :limit => 50
    t.string   "gapf_parent_2_address_2",                       :limit => 50
    t.string   "gapf_parent_2_address_city",                    :limit => 50
    t.string   "gapf_parent_2_address_state",                   :limit => 50
    t.integer  "gapf_parent_2_address_zip"
    t.integer  "gapf_parent_2_home_phone_1"
    t.integer  "gapf_parent_2_home_phone_2"
    t.integer  "gapf_parent_2_home_phone_3"
    t.integer  "gapf_parent_2_work_phone_1"
    t.integer  "gapf_parent_2_work_phone_2"
    t.integer  "gapf_parent_2_work_phone_3"
    t.integer  "gapf_parent_2_mobile_phone_1"
    t.integer  "gapf_parent_2_mobile_phone_2"
    t.integer  "gapf_parent_2_mobile_phone_3"
    t.integer  "gapf_parent_2_other_phone_1"
    t.integer  "gapf_parent_2_other_phone_2"
    t.integer  "gapf_parent_2_other_phone_3"
    t.string   "gapf_parent_2_email",                           :limit => 50
  end

  create_table "girl_scouts_fields", :force => true do |t|
    t.string   "tab_name"
    t.string   "field_name"
    t.boolean  "central_texas"
    t.boolean  "diamonds"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "alaska"
    t.boolean  "arizona_cactus_pine"
  end

  create_table "girls_scouts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "parent_name"
    t.string   "email"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "parent_first_name"
    t.string   "parent_last_name"
    t.integer  "service_provider_id"
  end

  create_table "iforms", :force => true do |t|
    t.string   "Self_Email_Address",                                              :limit => 100
    t.string   "Self_Name_First",                                                 :limit => 50
    t.string   "Self_Name_Last",                                                  :limit => 50
    t.string   "Self_Name_Middle",                                                :limit => 50
    t.string   "Self_Name_Honorific",                                             :limit => 10
    t.string   "Self_Name_Preferred",                                             :limit => 50
    t.string   "Self_Sex",                                                        :limit => 1
    t.integer  "Self_Age"
    t.string   "Self_Social_Security_Number",                                     :limit => 10
    t.string   "Self_Home_Address1",                                              :limit => 100
    t.string   "Self_Home_Address2",                                              :limit => 100
    t.string   "Self_Home_City",                                                  :limit => 50
    t.string   "Self_Home_State",                                                 :limit => 15
    t.string   "Self_Home_Postal_Code",                                           :limit => 10
    t.string   "Self_Marital_Status",                                             :limit => 10
    t.string   "Self_Phone_Home",                                                 :limit => 10
    t.string   "Self_Phone_Mobile",                                               :limit => 10
    t.string   "Self_Phone_Work",                                                 :limit => 10
    t.string   "Self_Phone_Work_Extension"
    t.string   "Self_Driver_License_State",                                       :limit => 15
    t.string   "Self_Driver_License_Number",                                      :limit => 15
    t.string   "Self_Employer_Name",                                              :limit => 25
    t.string   "Self_Employer_Address1",                                          :limit => 50
    t.string   "Self_Employer_Address2",                                          :limit => 50
    t.string   "Self_Employer_City",                                              :limit => 20
    t.string   "Self_Employer_State",                                             :limit => 15
    t.string   "Self_Employer_Postal_Code",                                       :limit => 10
    t.string   "Self_Length_Of_Employment",                                       :limit => 25
    t.string   "Self_Occupation",                                                 :limit => 50
    t.string   "Self_General_Dentist_Name",                                       :limit => 50
    t.string   "Self_Referred_By",                                                :limit => 50
    t.string   "Self_Other_Family_Members",                                       :limit => 50
    t.string   "Self_Best_Contact_Method",                                        :limit => 50
    t.string   "Self_Best_Contact_Time"
    t.date     "Date_Time_Form_Submitted_By_Consumer_To_Service_Provider"
    t.date     "Self_Birthdate"
    t.date     "Self_General_Dentist_Date_Last_Appointment"
    t.string   "Spouse_Name_First",                                               :limit => 50
    t.string   "Spouse_Name_Last",                                                :limit => 50
    t.string   "Spouse_Name_Middle",                                              :limit => 50
    t.string   "Spouse_Employer_Name",                                            :limit => 50
    t.string   "Spouse_Phone_Work",                                               :limit => 10
    t.string   "Spouse_Social_Security_Number",                                   :limit => 10
    t.string   "Spouse_Phone_Work_Extension"
    t.date     "Spouse_Birthdate"
    t.string   "Person_Responsible_For_Account_Name_First",                       :limit => 50
    t.string   "Person_Responsible_For_Account_Name_Last",                        :limit => 50
    t.string   "Person_Responsible_For_Account_Name_Middle",                      :limit => 50
    t.string   "Person_Responsible_For_Account_Phone_Work",                       :limit => 10
    t.string   "Person_Responsible_For_Account_Phone_Work_Extension"
    t.string   "Person_Responsible_For_Account_Phone_Home",                       :limit => 10
    t.string   "Person_Responsible_For_Account_Employer_Name",                    :limit => 15
    t.string   "Person_Responsible_For_Account_Social_Security_Number",           :limit => 10
    t.string   "Person_Responsible_For_Account_Address1",                         :limit => 100
    t.string   "Person_Responsible_For_Account_Address2",                         :limit => 100
    t.string   "Person_Responsible_For_Account_City",                             :limit => 20
    t.string   "Person_Responsible_For_Account_State",                            :limit => 15
    t.string   "Person_Responsible_For_Account_Postal_Code",                      :limit => 10
    t.string   "Person_Responsible_For_Account_Relationship",                     :limit => 50
    t.string   "Person_Responsible_For_Account_Drivers_License_State",            :limit => 15
    t.string   "Person_Responsible_For_Account_Drivers_License_Number",           :limit => 15
    t.boolean  "Insurance_Company_Primary_Orthodontic_Coverage"
    t.boolean  "Insurance_Company_Primary_Dental_Coverage"
    t.string   "Insurance_Company_Primary_Name",                                  :limit => 50
    t.string   "Insurance_Company_Primary_Address1",                              :limit => 100
    t.string   "Insurance_Company_Primary_Address2",                              :limit => 100
    t.string   "Insurance_Company_Primary_City",                                  :limit => 20
    t.string   "Insurance_Company_Primary_State",                                 :limit => 15
    t.string   "Insurance_Company_Primary_Postal_Code",                           :limit => 10
    t.string   "Insurance_Company_Primary_Phone",                                 :limit => 10
    t.string   "Insurance_Company_Primary_Group_Plan_Local_Policy_Number",        :limit => 50
    t.string   "Insurance_Company_Primary_Insured_Name_First",                    :limit => 50
    t.string   "Insurance_Company_Primary_Insured_Name_Last",                     :limit => 50
    t.string   "Insurance_Company_Primary_Insured_Relationship",                  :limit => 20
    t.date     "Insurance_Company_Primary_Insured_Birthdate"
    t.string   "Insurance_Company_Primary_Insured_Social_Security_Number",        :limit => 10
    t.string   "Insurance_Company_Primary_Insured_Employer_Name",                 :limit => 50
    t.boolean  "Insurance_Company_Secondary_Orthodontic_Coverage"
    t.boolean  "Insurance_Company_Secondary_Dental_Coverage"
    t.string   "Insurance_Company_Secondary_Name",                                :limit => 50
    t.string   "Insurance_Company_Secondary_Address1",                            :limit => 100
    t.string   "Insurance_Company_Secondary_Address2",                            :limit => 100
    t.string   "Insurance_Company_Secondary_City",                                :limit => 20
    t.string   "Insurance_Company_Secondary_State",                               :limit => 15
    t.string   "Insurance_Company_Secondary_Postal_Code",                         :limit => 10
    t.string   "Insurance_Company_Secondary_Phone",                               :limit => 10
    t.string   "Insurance_Company_Secondary_Group_Plan_Local_Policy_Number",      :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Name_First",                  :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Name_Last",                   :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Relationship",                :limit => 50
    t.date     "Insurance_Company_Secondary_Insured_Birthdate"
    t.string   "Insurance_Company_Secondary_Insured_Social_Security_Number",      :limit => 50
    t.string   "Insurance_Company_Secondary_Insured_Employer_Name",               :limit => 50
    t.string   "Emergency_Contact_Name_First",                                    :limit => 50
    t.string   "Emergency_Contact_Name_Last",                                     :limit => 50
    t.string   "Emergency_Contact_Relationship",                                  :limit => 50
    t.string   "Emergency_Contact_Phone_Work",                                    :limit => 10
    t.string   "Emergency_Contact_Phone_Home",                                    :limit => 10
    t.boolean  "Med_His_Personal_Physician"
    t.string   "Med_His_Personal_Physician_Name_First",                           :limit => 50
    t.string   "Med_His_Personal_Physician_Name_Last",                            :limit => 50
    t.string   "Med_His_Personal_Physician_Phone",                                :limit => 10
    t.date     "Med_His_Personal_Physician_Date_Of_Last_Visit"
    t.string   "Med_His_Current_Physical_Health",                                 :limit => 5
    t.boolean  "Med_His_Currently_Under_The_Care_Of_A_Physician"
    t.string   "Med_His_Currently_Under_The_Care_Of_A_Physician_Desc"
    t.boolean  "Med_His_Currently_Taking_Presc_Drugs"
    t.boolean  "Med_His_Currently_Taking_Over_The_Counter_Drugs"
    t.string   "Med_His_Currently_Taking_Presc_Drugs_List"
    t.string   "Med_His_Currently_Taking_Over_The_Counter_Drugs_List"
    t.boolean  "Med_His_Currently_Taking_Birth_Control_Pills"
    t.boolean  "Med_His_Currently_Pregnant"
    t.string   "Med_His_Weeks_Pregnant",                                          :limit => 20
    t.boolean  "Med_His_Currently_Nursing"
    t.boolean  "Med_His_Abnormal_Bleeding"
    t.boolean  "Med_His_Anemia"
    t.boolean  "Med_His_Artificial_Bones_Joints_Valves"
    t.boolean  "Med_His_Asthma"
    t.boolean  "Med_His_Blood_Transfusion"
    t.boolean  "Med_His_Cancer"
    t.boolean  "Med_His_Congenital_Heart_Defect"
    t.boolean  "Med_His_Diabetes"
    t.boolean  "Med_His_Difficulty_Breathing"
    t.boolean  "Med_His_Drug_Abuse"
    t.boolean  "Med_His_Emphysema"
    t.boolean  "Med_His_Epilepsy"
    t.boolean  "Med_His_Fever_Blisters"
    t.boolean  "Med_His_Glaucoma"
    t.boolean  "Med_His_Heart_Attack"
    t.boolean  "Med_His_Stroke"
    t.boolean  "Med_His_Heart_Murmur"
    t.boolean  "Med_His_Heart_Surgery"
    t.boolean  "Med_His_Pacemaker"
    t.boolean  "Med_His_Hemophilia"
    t.boolean  "Med_His_Hepatitis"
    t.boolean  "Med_His_High_Blood_Pressure"
    t.boolean  "Med_His_Low_Blood_Pressure"
    t.boolean  "Med_His_AIDS"
    t.boolean  "Med_His_HIV_Positive"
    t.boolean  "Med_His_Hospitalized_For_Any_Reason"
    t.boolean  "Med_His_Kidney_Problems"
    t.boolean  "Med_His_Mitral_Valve_Prolapse"
    t.boolean  "Med_His_Psychiatric_Problems"
    t.boolean  "Med_His_Radiation_Treatment"
    t.boolean  "Med_His_Rheumatic_Fever"
    t.boolean  "Med_His_Scarlet_Fever"
    t.boolean  "Med_His_Frequent_Headaches"
    t.boolean  "Med_His_Shingles"
    t.boolean  "Med_His_Sickle_Cell_Disease"
    t.boolean  "Med_His_Sickle_Cell_Disease_Traits"
    t.boolean  "Med_His_Sinus_Problems"
    t.boolean  "Med_His_Tuberculosis"
    t.boolean  "Med_His_Ulcers"
    t.boolean  "Med_His_Venereal_Disease"
    t.string   "Med_His_Serious_Medical_Issues"
    t.boolean  "Allergic_To_Aspirin"
    t.boolean  "Allergic_To_Metals"
    t.boolean  "Allergic_To_Plastics"
    t.boolean  "Allergic_To_Codeine"
    t.boolean  "Allergic_To_Dental_Anesthetics"
    t.boolean  "Allergic_To_Erythromycin"
    t.boolean  "Allergic_To_Latex"
    t.boolean  "Allergic_To_Penicillin"
    t.boolean  "Allergic_To_Tetracycline"
    t.boolean  "Allergic_To_Other"
    t.string   "Dental_History_Orthodontic_Goals"
    t.boolean  "Dental_History_Previous_Orthodontic_Evaluation"
    t.boolean  "Dental_History_Previous_Dental_Work_Issues"
    t.boolean  "Dental_History_TMJ_TMD_Issues_Previous"
    t.boolean  "Dental_History_TMJ_TMD_Issues_Current"
    t.string   "Dental_History_Current_Dental_Health",                            :limit => 5
    t.string   "Dental_History_Injury_To_Chin",                                   :limit => 6
    t.string   "Dental_History_Injury_To_Teeth",                                  :limit => 6
    t.string   "Dental_History_Injury_To_Mouth",                                  :limit => 6
    t.boolean  "Dental_History_Like_Smile"
    t.boolean  "Dental_History_Bleeding_Gums"
    t.boolean  "Dental_History_Habits_Mouth_Breather"
    t.string   "Dental_History_Breathe_Through_Mouth_While_Awake",                :limit => 10
    t.string   "Dental_History_Breathe_Through_Mouth_While_Asleep",               :limit => 10
    t.boolean  "Dental_History_Any_Extra_Permanent_Teeth"
    t.boolean  "Dental_History_Any_Missing_Teeth"
    t.boolean  "Dental_History_Ever_Taken_PhenFen_Redux_Pondimin"
    t.string   "Dental_History_When_Taken_PhenFen_Redux_Pondimin",                :limit => 50
    t.boolean  "Dental_History_Tobacco_Smoke"
    t.boolean  "Dental_History_Tobacco_Smokeless"
    t.string   "path"
    t.string   "formname",                                                        :limit => 50
    t.integer  "appointment_id"
    t.datetime "created_at",                                                                            :null => false
    t.datetime "updated_at",                                                                            :null => false
    t.boolean  "Accompanying_Your_Child_Today_Has_Legal_Custody_Of_Child"
    t.string   "Accompanying_Your_Child_Today_Relationship",                      :limit => 20
    t.string   "Accompanying_Your_Child_Today_Siblings_And_Ages",                 :limit => 100
    t.string   "Accompanying_Your_Child_Today_Name_First",                        :limit => 50
    t.string   "Accompanying_Your_Child_Today_Name_Last",                         :limit => 50
    t.boolean  "Allergic_To_Any_Drugs"
    t.boolean  "Dental_History_Brush_Teeth_Daily"
    t.boolean  "Dental_History_Floss_Teeth_Daily"
    t.string   "Dental_History_Injury_To_Face",                                   :limit => 6
    t.string   "Dental_History_Play_Musical_Instruments",                         :limit => 100
    t.boolean  "Dental_History_Previous_Orthodontic_Treatment"
    t.boolean  "Dental_History_Tonsils_Removed"
    t.string   "Father_Drivers_License_Number",                                   :limit => 10
    t.string   "Father_Drivers_License_State",                                    :limit => 15
    t.string   "Father_Employer_Name",                                            :limit => 50
    t.string   "Father_Job_Title",                                                :limit => 50
    t.string   "Father_Length_Of_Employment",                                     :limit => 20
    t.string   "Father_Name_First",                                               :limit => 50
    t.string   "Father_Name_Last",                                                :limit => 50
    t.string   "Father_Name_Middle",                                              :limit => 50
    t.string   "Father_Phone_Home",                                               :limit => 10
    t.date     "Father_Birthdate"
    t.string   "Father_Phone_Work",                                               :limit => 10
    t.string   "Father_Phone_Work_Extension"
    t.string   "Father_Social_Security_Number",                                   :limit => 10
    t.string   "Father_Stepfather_Or_Gaurdian",                                   :limit => 10
    t.boolean  "Habits_Bottle"
    t.boolean  "Habits_Breast_Fed"
    t.boolean  "Habits_Clenching_Or_Grinding_Teeth"
    t.boolean  "Habits_Lip_Sucking_Or_Biting"
    t.boolean  "Habits_Mouth_Breather"
    t.boolean  "Habits_Nail_Biting"
    t.boolean  "Habits_Nursing"
    t.boolean  "Habits_Speech_Problems"
    t.boolean  "Habits_Thumb_Or_Finger_Sucking"
    t.boolean  "Habits_Tongue_Thrust"
    t.boolean  "Med_His_ADD"
    t.boolean  "Med_His_ADHD"
    t.boolean  "Med_His_Any_Operations"
    t.boolean  "Med_His_Handicaps_Or_Disabilities"
    t.boolean  "Med_His_Hearing_Impairment"
    t.boolean  "Med_His_Liver_Problems"
    t.boolean  "Med_His_Lupus"
    t.string   "Med_His_Medical_Problems"
    t.boolean  "Med_His_Menstruation_Begun"
    t.boolean  "Med_His_Puberty_Begun"
    t.string   "Mother_Drivers_License_Number",                                   :limit => 15
    t.string   "Mother_Drivers_License_State",                                    :limit => 15
    t.string   "Mother_Employer_Name",                                            :limit => 50
    t.string   "Mother_Job_Title",                                                :limit => 30
    t.string   "Mother_Length_Of_Employment",                                     :limit => 20
    t.string   "Mother_Name_First",                                               :limit => 50
    t.string   "Mother_Name_Last",                                                :limit => 50
    t.string   "Mother_Name_Middle",                                              :limit => 50
    t.date     "Mother_Birthdate"
    t.string   "Mother_Phone_Home",                                               :limit => 10
    t.string   "Mother_Phone_Work",                                               :limit => 10
    t.string   "Mother_Phone_Work_Extension"
    t.string   "Mother_Social_Security_Number",                                   :limit => 10
    t.string   "Mother_Stepmother_Or_Gaurdian",                                   :limit => 10
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Address1",               :limit => 100
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Address2",               :limit => 100
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_City",                   :limit => 20
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Name_First",             :limit => 50
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Name_Last",              :limit => 50
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Name_Middle",            :limit => 50
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Phone",                  :limit => 10
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_Postal_Code",            :limit => 10
    t.string   "Neighbor_Or_Relative_Not_Living_With_You_State",                  :limit => 15
    t.string   "Person_Responsible_For_Account_Payment_Method",                   :limit => 15
    t.string   "Person_Responsible_For_Account_Previous_Address1",                :limit => 100
    t.string   "Person_Responsible_For_Account_Previous_Address2",                :limit => 100
    t.string   "Person_Responsible_For_Account_Previous_City",                    :limit => 20
    t.string   "Person_Responsible_For_Account_Previous_Postal_Code",             :limit => 10
    t.string   "Person_Responsible_For_Account_Previous_State",                   :limit => 15
    t.string   "Person_Responsible_For_Making_Appointments_Name_First",           :limit => 50
    t.string   "Person_Responsible_For_Making_Appointments_Name_Last",            :limit => 50
    t.string   "Person_Responsible_For_Making_Appointments_Name_Middle",          :limit => 50
    t.string   "Person_Responsible_For_Making_Appointments_Phone_Home",           :limit => 10
    t.string   "Person_Responsible_For_Making_Appointments_Phone_Work",           :limit => 10
    t.string   "Person_Responsible_For_Making_Appointments_Phone_Work_Extension"
    t.string   "Self_Grade",                                                      :limit => 20
    t.string   "Self_Hobbies",                                                    :limit => 100
    t.string   "Self_School",                                                     :limit => 50
    t.string   "Allergic_To_Drugs_List"
    t.string   "Dental_History_Habits_Speech_Problems"
    t.binary   "pdffile_path",                                                    :limit => 2147483647
    t.integer  "ssn_1"
    t.integer  "ssn_2"
    t.integer  "ssn_3"
    t.string   "best_number_to_reach"
    t.string   "person_responsible_for_ac"
    t.string   "smile_evaluation_whiteness"
    t.string   "smile_evaluation_staining"
    t.string   "smile_evaluation_alignment_of_test"
    t.string   "smile_evaluation_chipping"
    t.string   "smile_evaluation_existing_dental_work"
    t.string   "smile_evaluation_gum_health"
    t.string   "smile_evaluation_smile_line"
    t.string   "anything_else_about_smile"
    t.integer  "home_phone_1"
    t.integer  "home_phone_2"
    t.integer  "home_phone_3"
    t.integer  "work_phone_1"
    t.integer  "work_phone_2"
    t.integer  "work_phone_3"
    t.integer  "cell_phone_1"
    t.integer  "cell_phone_2"
    t.integer  "cell_phone_3"
    t.integer  "employer_phone_1"
    t.integer  "employer_phone_2"
    t.integer  "employer_phone_3"
    t.integer  "emergency_contact_phone_1"
    t.integer  "emergency_contact_phone_2"
    t.integer  "emergency_contact_phone_3"
    t.string   "how_did_you_hear_about_office"
    t.string   "relationship_to_patient"
    t.string   "billing_details_first_name"
    t.string   "billing_details_last_name"
    t.string   "billing_details_address1"
    t.string   "billing_details_address2"
    t.string   "billing_details_address_city"
    t.string   "billing_details_address_state"
    t.string   "billing_details_address_postal_code"
    t.integer  "billing_details_home_phone_1"
    t.integer  "billing_details_home_phone_2"
    t.integer  "billing_details_home_phone_3"
    t.integer  "billing_details_work_phone_1"
    t.integer  "billing_details_work_phone_2"
    t.integer  "billing_details_work_phone_3"
    t.integer  "billing_details_cell_phone_1"
    t.integer  "billing_details_cell_phone_2"
    t.integer  "billing_details_cell_phone_3"
    t.integer  "billing_details_ssn"
    t.integer  "billing_details_driving_licence_number"
    t.string   "billing_details_driving_licence_state"
    t.string   "billing_details_employer_name"
    t.string   "billing_details_employer_address1"
    t.string   "billing_details_employer_address2"
    t.string   "billing_details_employer_address_city"
    t.string   "billing_details_employer_address_state"
    t.string   "billing_details_employer_address_postal_code"
    t.integer  "billing_details_employer_phone_1"
    t.integer  "billing_details_employer_phone_2"
    t.integer  "billing_details_employer_phone_3"
    t.integer  "billing_details_ssn_1"
    t.integer  "billing_details_ssn_2"
    t.integer  "billing_details_ssn_3"
    t.date     "billing_birth_date"
    t.integer  "patient_other_phone_1"
    t.integer  "patient_other_phone_2"
    t.integer  "patient_other_phone_3"
    t.string   "patient_previously_siblings_list",                                :limit => 100
    t.string   "patient_guardian_father_first_name",                              :limit => 50
    t.string   "patient_guardian_father_last_name",                               :limit => 50
    t.date     "patient_guardian_father_birth_date"
    t.integer  "patient_guardian_father_ssn_1"
    t.integer  "patient_guardian_father_ssn_2"
    t.integer  "patient_guardian_father_ssn_3"
    t.string   "patient_guardian_father_address_1",                               :limit => 50
    t.string   "patient_guardian_father_address_2",                               :limit => 50
    t.string   "patient_guardian_father_address_city",                            :limit => 50
    t.string   "patient_guardian_father_address_state",                           :limit => 50
    t.string   "patient_guardian_father_address_zip",                             :limit => 50
    t.integer  "patient_guardian_father_home_phone_1"
    t.integer  "patient_guardian_father_home_phone_2"
    t.integer  "patient_guardian_father_home_phone_3"
    t.integer  "patient_guardian_father_work_phone_1"
    t.integer  "patient_guardian_father_work_phone_2"
    t.integer  "patient_guardian_father_work_phone_3"
    t.integer  "patient_guardian_father_cell_phone_1"
    t.integer  "patient_guardian_father_cell_phone_2"
    t.integer  "patient_guardian_father_cell_phone_3"
    t.string   "patient_guardian_father_email",                                   :limit => 50
    t.string   "patient_guardian_mother_first_name",                              :limit => 50
    t.string   "patient_guardian_mother_last_name",                               :limit => 50
    t.date     "patient_guardian_mother_birth_date"
    t.integer  "patient_guardian_mother_ssn_1"
    t.integer  "patient_guardian_mother_ssn_2"
    t.integer  "patient_guardian_mother_ssn_3"
    t.string   "patient_guardian_mother_address_1",                               :limit => 50
    t.string   "patient_guardian_mother_address_2",                               :limit => 50
    t.string   "patient_guardian_mother_address_city",                            :limit => 50
    t.string   "patient_guardian_mother_address_state",                           :limit => 50
    t.string   "patient_guardian_mother_address_zip",                             :limit => 50
    t.integer  "patient_guardian_mother_home_phone_1"
    t.integer  "patient_guardian_mother_home_phone_2"
    t.integer  "patient_guardian_mother_home_phone_3"
    t.integer  "patient_guardian_mother_work_phone_1"
    t.integer  "patient_guardian_mother_work_phone_2"
    t.integer  "patient_guardian_mother_work_phone_3"
    t.integer  "patient_guardian_mother_cell_phone_1"
    t.integer  "patient_guardian_mother_cell_phone_2"
    t.integer  "patient_guardian_mother_cell_phone_3"
    t.string   "patient_guardian_mother_email",                                   :limit => 50
    t.string   "insurance_person_first_name",                                     :limit => 50
    t.string   "insurance_person_last_name",                                      :limit => 50
    t.string   "insurance_relation_ship_to_patient",                              :limit => 50
    t.string   "insurance_member_id",                                             :limit => 50
    t.string   "insurance_company_name",                                          :limit => 50
    t.integer  "insurance_phone_1"
    t.integer  "insurance_phone_2"
    t.integer  "insurance_phone_3"
    t.string   "insurance_group",                                                 :limit => 50
    t.boolean  "dental_history_cavities"
    t.boolean  "dental_history_crooked_teeth"
    t.boolean  "dental_history_sensitive_to_hot_or_cold"
    t.boolean  "dental_history_loose_teeth"
    t.boolean  "dental_history_toothache"
    t.boolean  "dental_history_sensitive_to_sweets"
    t.boolean  "dental_history_frequent_headaches"
    t.boolean  "dental_history_teeth_bumped"
    t.boolean  "dental_history_bad_breath"
    t.boolean  "dental_history_patient_bleeding_gums"
    t.boolean  "dental_history_discolored_teeth"
    t.boolean  "dental_history_tmj_popping_or_clicking"
    t.boolean  "dental_history_jaw_pain_from_joint"
    t.boolean  "dental_history_thumb_sucking"
    t.boolean  "dental_history_pacifier_use"
    t.boolean  "dental_history_lip_biting"
    t.boolean  "dental_history_teeth_grinding"
    t.boolean  "dental_history_other"
    t.string   "dental_history_does_child_brush_teeth",                           :limit => 50
    t.string   "dental_history_does_child_flosh_teeth",                           :limit => 25
    t.string   "dental_history_age_at_stop_bottle",                               :limit => 25
    t.string   "dental_history_age_at_stop_bottle_sippy_cup",                     :limit => 25
    t.string   "medical_history_address_1",                                       :limit => 50
    t.string   "medical_history_address_2",                                       :limit => 50
    t.string   "medical_history_address_city",                                    :limit => 50
    t.string   "medical_history_address_state",                                   :limit => 50
    t.string   "medical_history_address_zip",                                     :limit => 50
    t.integer  "medical_history_home_phone_1"
    t.integer  "medical_history_home_phone_2"
    t.integer  "medical_history_home_phone_3"
    t.boolean  "medical_history_latex_allergies"
    t.boolean  "medical_history_seasonal_allergies"
    t.string   "medical_history_induces_breathing_prob",                          :limit => 50
    t.string   "medical_history_asthma_medication",                               :limit => 50
    t.string   "medical_history_autism_spectrum",                                 :limit => 10
    t.string   "medical_history_sensory_integration_issues",                      :limit => 10
    t.string   "medical_history_add_or_adhd",                                     :limit => 10
    t.string   "medical_history_heart_trouble_or_heart_murmur",                   :limit => 10
    t.string   "medical_history_rheumatic_heart_disease_or_fever",                :limit => 10
    t.string   "medical_history_blood_diseases_or_anemia",                        :limit => 10
    t.string   "medical_history_aids_virus",                                      :limit => 10
    t.string   "medical_history_herpes_virus_or_shingles",                        :limit => 10
    t.string   "medical_history_diabetes",                                        :limit => 10
    t.string   "medical_history_ear_eye_nose_or_throat_trouble",                  :limit => 10
    t.string   "medical_history_stomach_ulcers",                                  :limit => 10
    t.string   "medical_history_hearing_or_vision_impairment",                    :limit => 10
    t.string   "medical_history_eating_disorders",                                :limit => 10
    t.string   "medical_history_abnormal_bleeding_or_bruising",                   :limit => 10
    t.string   "medical_history_prolonged_bleeding_or_transfusions",              :limit => 10
    t.string   "medical_history_birth_defects",                                   :limit => 10
    t.string   "medical_history_kidney_disease",                                  :limit => 10
    t.string   "medical_history_cleft_lip_or_palate",                             :limit => 10
    t.string   "medical_history_scarlet_fever_or_high_fever",                     :limit => 10
    t.string   "medical_history_high_or_low_blood_pressure",                      :limit => 10
    t.string   "medical_history_liver_disease",                                   :limit => 10
    t.string   "medical_history_Jaundice_or_hepatitis",                           :limit => 10
    t.string   "medical_history_steroids_therapy_or_chemotherapy",                :limit => 10
    t.string   "medical_history_nervous_or_emotional_disorders",                  :limit => 10
    t.string   "medical_history_Convulsions_or_seizures",                         :limit => 10
    t.date     "medical_history_date_of_last_seizure"
    t.string   "medical_history_frequent_diarrhea_or_vomiting",                   :limit => 10
    t.string   "medical_history_mumps_measles_or_chickenpox",                     :limit => 10
    t.string   "medical_history_cancer_tumors_growths_or_cysts",                  :limit => 10
    t.string   "medical_history_sinus_problems_or_drainage",                      :limit => 10
    t.string   "medical_history_tuberculosis_or_tb_exposure",                     :limit => 10
    t.string   "medical_history_problems_with_anesthesia",                        :limit => 10
    t.string   "medical_history_thyroid_disease",                                 :limit => 10
    t.string   "medical_history_current_medication_name_1",                       :limit => 50
    t.string   "medical_history_current_medication_how_often_1",                  :limit => 50
    t.string   "medical_history_current_medication_reason_1",                     :limit => 50
    t.string   "medical_history_current_medication_name_2",                       :limit => 50
    t.string   "medical_history_current_medication_how_often_2",                  :limit => 50
    t.string   "medical_history_current_medication_reason_2",                     :limit => 50
    t.string   "medical_history_current_medication_name_3",                       :limit => 50
    t.string   "medical_history_current_medication_how_often_3",                  :limit => 50
    t.string   "medical_history_current_medication_reason_3",                     :limit => 50
    t.string   "medical_history_current_medication_name_4",                       :limit => 50
    t.string   "medical_history_current_medication_how_often_4",                  :limit => 50
    t.string   "medical_history_current_medication_reason_4",                     :limit => 50
    t.string   "patient_guardian_father_employer",                                :limit => 50
    t.string   "patient_guardian_father",                                         :limit => 25
    t.string   "patient_guardian_mother",                                         :limit => 25
    t.string   "patient_guardian_mother_employer",                                :limit => 50
    t.string   "insurance_insured"
    t.string   "insurance_employer",                                              :limit => 50
    t.string   "insurance_address_1",                                             :limit => 50
    t.string   "insurance_address_2",                                             :limit => 50
    t.string   "insurance_address_city",                                          :limit => 50
    t.string   "insurance_address_state",                                         :limit => 50
    t.string   "insurance_address_zip",                                           :limit => 50
    t.string   "dental_history_why_patient_here_today"
    t.string   "dental_history_patient_first_time_to_visit",                      :limit => 15
    t.date     "dental_history_patient_last_visiting_date"
    t.boolean  "dental_history_patient_behave_today_friendly"
    t.boolean  "dental_history_patient_behave_today_happy"
    t.boolean  "dental_history_patient_behave_today_timid"
    t.boolean  "dental_history_patient_behave_today_afraid"
    t.boolean  "dental_history_patient_behave_today_resistance"
    t.string   "dental_history_patient_receive_fluoride_in_any_form",             :limit => 15
    t.string   "dental_history_patient_receive_fluoride_in_any_form_description", :limit => 15
    t.string   "dental_history_patient_inherited_any_dental_characteristics",     :limit => 50
    t.string   "dental_history_patient_have_any_injuries",                        :limit => 50
    t.string   "medical_history_physician",                                       :limit => 50
    t.string   "medical_history_patient_good_general_health_description",         :limit => 50
    t.string   "medical_history_patient_physical_disabilities_description",       :limit => 50
    t.string   "medical_history_patient_surgical_operations_description",         :limit => 50
    t.string   "medical_history_patient_ever_been_hospitalized_description",      :limit => 50
    t.boolean  "medical_history_food_allergies"
    t.boolean  "medical_history_drug_allergies"
    t.string   "medical_history_food_allergies_description",                      :limit => 50
    t.string   "medical_history_drug_allergies_description",                      :limit => 50
    t.boolean  "social_history_patient_have_problems_speech"
    t.boolean  "social_history_patient_have_problems_hearing"
    t.boolean  "social_history_patient_have_problems_vision"
    t.boolean  "social_history_patient_have_problems_sleep"
    t.boolean  "social_history_patient_is_adv_in_learning"
    t.boolean  "social_history_patient_is_progressing_normally"
    t.boolean  "social_history_patient_is_slow_learner"
    t.string   "social_history_patient_first_lang",                               :limit => 50
    t.string   "social_history_patient_second_lang",                              :limit => 50
    t.string   "social_history_patient_adopted",                                  :limit => 5
    t.string   "social_history_patient_adopted_age",                              :limit => 20
    t.string   "social_history_patient_tolerate",                                 :limit => 50
    t.string   "social_history_patient_favorites",                                :limit => 50
    t.string   "medical_history_asthama_or_breathing_prob",                       :limit => 25
    t.string   "medical_history_er_for_asthma_attack",                            :limit => 25
    t.string   "medical_history_asthama_or_breathing_prob_description",           :limit => 50
    t.string   "medical_history_er_for_asthma_attack_description",                :limit => 50
    t.string   "insurance_do_you_have_more_than_one_dental_insurance",            :limit => 10
    t.string   "medical_history_patient_good_general_health",                     :limit => 10
    t.string   "medical_history_patient_physical_disabilities",                   :limit => 10
    t.string   "medical_history_patient_booster_shoot_up_to_date",                :limit => 10
    t.string   "medical_history_patient_surgical_operations",                     :limit => 10
    t.string   "medical_history_patient_ever_been_hospitalized",                  :limit => 10
    t.string   "dental_history_does_child_brush_teeth_electric_tooth_brush",      :limit => 10
    t.string   "social_history_patient_is",                                       :limit => 20
    t.string   "insurance_second_insurance_company_name",                         :limit => 50
    t.string   "dental_history_oral_habits_other_description",                    :limit => 50
    t.string   "patient_guardian_mother_other_description",                       :limit => 50
    t.string   "patient_guardian_father_other_description",                       :limit => 50
  end

  create_table "medical_appointments", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "service_provider_id"
    t.integer  "doctor_user_id"
    t.integer  "patient_user_id"
    t.string   "firstname"
    t.string   "preferred_name"
    t.string   "email"
    t.string   "lastname"
    t.string   "responsible_party"
    t.string   "doctorname"
    t.string   "location"
    t.datetime "appointment_date_time"
    t.string   "formname"
    t.string   "timesent"
    t.string   "timereceived"
    t.string   "status"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "medical_patient_forms", :force => true do |t|
    t.integer  "service_provider_id"
    t.integer  "medical_appointment_id"
    t.integer  "doctor_user_id"
    t.integer  "patient_user_id"
    t.string   "first_name",                                                :limit => 50
    t.string   "last_name",                                                 :limit => 50
    t.string   "middle_name",                                               :limit => 50
    t.string   "address_1",                                                 :limit => 50
    t.string   "address_2",                                                 :limit => 50
    t.string   "address_city",                                              :limit => 50
    t.string   "address_state",                                             :limit => 50
    t.integer  "address_zip"
    t.integer  "home_phone_1",                                              :limit => 8
    t.integer  "home_phone_2",                                              :limit => 8
    t.integer  "home_phone_3",                                              :limit => 8
    t.integer  "work_phone_1",                                              :limit => 8
    t.integer  "work_phone_2",                                              :limit => 8
    t.integer  "work_phone_3",                                              :limit => 8
    t.integer  "cell_phone_1",                                              :limit => 8
    t.integer  "cell_phone_2",                                              :limit => 8
    t.integer  "cell_phone_3",                                              :limit => 8
    t.string   "sex",                                                       :limit => 10
    t.date     "birth_date"
    t.string   "marital_status",                                            :limit => 15
    t.integer  "ssn_1",                                                     :limit => 8
    t.integer  "ssn_2",                                                     :limit => 8
    t.integer  "ssn_3",                                                     :limit => 8
    t.string   "referred_to_our_office_by",                                 :limit => 25
    t.string   "referral_name",                                             :limit => 25
    t.string   "employer",                                                  :limit => 50
    t.string   "employer_occupation",                                       :limit => 50
    t.string   "employer_address_1",                                        :limit => 50
    t.string   "employer_address_2",                                        :limit => 50
    t.string   "employer_address_city",                                     :limit => 50
    t.string   "employer_address_state",                                    :limit => 50
    t.integer  "employer_address_zip"
    t.string   "spouse_first_name",                                         :limit => 50
    t.string   "spouse_last_name",                                          :limit => 50
    t.integer  "spouse_home_phone_1",                                       :limit => 8
    t.integer  "spouse_home_phone_2",                                       :limit => 8
    t.integer  "spouse_home_phone_3",                                       :limit => 8
    t.integer  "spouse_work_phone_1",                                       :limit => 8
    t.integer  "spouse_work_phone_2",                                       :limit => 8
    t.integer  "spouse_work_phone_3",                                       :limit => 8
    t.string   "emergency_contact_first_name",                              :limit => 50
    t.string   "emergency_contact_last_name",                               :limit => 50
    t.string   "emergency_contact_relationship",                            :limit => 50
    t.integer  "emergency_contact_phone_1",                                 :limit => 8
    t.integer  "emergency_contact_phone_2",                                 :limit => 8
    t.integer  "emergency_contact_phone_3",                                 :limit => 8
    t.string   "emergency_contact_who_referred_you",                        :limit => 50
    t.string   "primary_insurance_company_name",                            :limit => 50
    t.string   "primary_insurance_address_1",                               :limit => 50
    t.string   "primary_insurance_address_2",                               :limit => 50
    t.string   "primary_insurance_address_city",                            :limit => 50
    t.string   "primary_insurance_address_state",                           :limit => 50
    t.string   "primary_insurance_address_zip",                             :limit => 50
    t.integer  "primary_insurance_phone_1",                                 :limit => 8
    t.integer  "primary_insurance_phone_2",                                 :limit => 8
    t.integer  "primary_insurance_phone_3",                                 :limit => 8
    t.string   "primary_insurance_id",                                      :limit => 25
    t.string   "primary_insurance_group",                                   :limit => 50
    t.string   "primary_insurance_policy_holder",                           :limit => 10
    t.string   "primary_insurance_policy_holder_first_name",                :limit => 50
    t.string   "primary_insurance_policy_holder_last_name",                 :limit => 50
    t.string   "primary_insurance_relationship",                            :limit => 50
    t.date     "primary_insurance_birth_date"
    t.integer  "primary_insurance_ssn_1",                                   :limit => 8
    t.integer  "primary_insurance_ssn_2",                                   :limit => 8
    t.integer  "primary_insurance_ssn_3",                                   :limit => 8
    t.string   "primary_insurance_policy_holder_employer",                  :limit => 50
    t.string   "secondary_insurance_company_name",                          :limit => 50
    t.string   "secondary_insurance_address_1",                             :limit => 50
    t.string   "secondary_insurance_address_2",                             :limit => 50
    t.string   "secondary_insurance_address_city",                          :limit => 50
    t.string   "secondary_insurance_address_state",                         :limit => 50
    t.integer  "secondary_insurance_address_zip"
    t.integer  "secondary_insurance_phone_1",                               :limit => 8
    t.integer  "secondary_insurance_phone_2",                               :limit => 8
    t.integer  "secondary_insurance_phone_3",                               :limit => 8
    t.string   "secondary_insurance_id",                                    :limit => 25
    t.string   "secondary_insurance_group",                                 :limit => 50
    t.string   "secondary_insurance_policy_holder",                         :limit => 10
    t.string   "secondary_insurance_policy_holder_first_name",              :limit => 50
    t.string   "secondary_insurance_policy_holder_last_name",               :limit => 50
    t.string   "secondary_insurance_relationship",                          :limit => 50
    t.date     "secondary_insurance_birth_date"
    t.integer  "secondary_insurance_ssn_1",                                 :limit => 8
    t.integer  "secondary_insurance_ssn_2",                                 :limit => 8
    t.integer  "secondary_insurance_ssn_3",                                 :limit => 8
    t.string   "secondary_insurance_policy_holder_employer",                :limit => 50
    t.string   "patient_consent_first_name_1",                              :limit => 50
    t.string   "patient_consent_last_name_1",                               :limit => 50
    t.string   "patient_consent_relation_ship_to_patient_1",                :limit => 50
    t.string   "patient_consent_first_name_2",                              :limit => 50
    t.string   "patient_consent_last_name_2",                               :limit => 50
    t.string   "patient_consent_relation_ship_to_patient_2",                :limit => 50
    t.string   "patient_consent_first_name_3",                              :limit => 50
    t.string   "patient_consent_last_name_3",                               :limit => 50
    t.string   "patient_consent_relation_ship_to_patient_3",                :limit => 50
    t.string   "patient_authorization_for_voice_mail",                      :limit => 25
    t.string   "medical_history_reason_for_visit_1",                        :limit => 50
    t.string   "medical_history_reason_for_visit_2",                        :limit => 50
    t.string   "medical_history_reason_for_visit_3",                        :limit => 50
    t.string   "medical_history_specialist_1",                              :limit => 50
    t.string   "medical_history_speciality_1",                              :limit => 50
    t.string   "medical_history_specialist_2",                              :limit => 50
    t.string   "medical_history_speciality_2",                              :limit => 50
    t.string   "medical_history_specialist_3",                              :limit => 50
    t.string   "medical_history_speciality_3",                              :limit => 50
    t.string   "medical_history_specialist_4",                              :limit => 50
    t.string   "medical_history_speciality_4",                              :limit => 50
    t.string   "medical_history_medication_medication_1",                   :limit => 50
    t.string   "medical_history_medication_dosage_1",                       :limit => 50
    t.string   "medical_history_medication_times_per_day_1",                :limit => 50
    t.string   "medical_history_medication_medication_2",                   :limit => 50
    t.string   "medical_history_medication_dosage_2",                       :limit => 50
    t.string   "medical_history_medication_times_per_day_2",                :limit => 50
    t.string   "medical_history_medication_medication_3",                   :limit => 50
    t.string   "medical_history_medication_dosage_3",                       :limit => 50
    t.string   "medical_history_medication_times_per_day_3",                :limit => 50
    t.string   "medical_history_medication_medication_4",                   :limit => 50
    t.string   "medical_history_medication_dosage_4",                       :limit => 50
    t.string   "medical_history_medication_times_per_day_4",                :limit => 50
    t.string   "medical_history_medication_medication_5",                   :limit => 50
    t.string   "medical_history_medication_dosage_5",                       :limit => 50
    t.string   "medical_history_medication_times_per_day_5",                :limit => 50
    t.string   "medical_history_medication_medication_6",                   :limit => 50
    t.string   "medical_history_medication_dosage_6",                       :limit => 50
    t.string   "medical_history_medication_times_per_day_6",                :limit => 50
    t.string   "medical_history_medication_medication_7",                   :limit => 50
    t.string   "medical_history_medication_dosage_7",                       :limit => 50
    t.string   "medical_history_medication_times_per_day_7",                :limit => 50
    t.string   "medical_history_medication_allergies_medication_1",         :limit => 50
    t.string   "medical_history_medication_allergies_reaction_1",           :limit => 50
    t.string   "medical_history_medication_allergies_medication_2",         :limit => 50
    t.string   "medical_history_medication_allergies_reaction_2",           :limit => 50
    t.string   "medical_history_medication_allergies_medication_3",         :limit => 50
    t.string   "medical_history_medication_allergies_reaction_3",           :limit => 50
    t.string   "medical_history_operations_operation_1",                    :limit => 50
    t.date     "medical_history_operations_operation_date_1"
    t.string   "medical_history_operations_operation_2",                    :limit => 50
    t.date     "medical_history_operations_operation_date_2"
    t.string   "medical_history_operations_operation_3",                    :limit => 50
    t.date     "medical_history_operations_operation_date_3"
    t.string   "medical_history_operations_operation_4",                    :limit => 50
    t.date     "medical_history_operations_operation_date_4"
    t.string   "medical_history_operations_operation_5",                    :limit => 50
    t.date     "medical_history_operations_operation_date_5"
    t.string   "medical_history_operations_operation_6",                    :limit => 50
    t.date     "medical_history_operations_operation_date_6"
    t.string   "medical_history_previous_illnesses_illness_1",              :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_1"
    t.string   "medical_history_previous_illnesses_illness_2",              :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_2"
    t.string   "medical_history_previous_illnesses_illness_3",              :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_3"
    t.string   "medical_history_previous_illnesses_illness_4",              :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_4"
    t.string   "medical_history_previous_illnesses_illness_5",              :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_5"
    t.string   "medical_history_previous_illnesses_illness_6",              :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_6"
    t.string   "medical_history_previous_illnesses_illness_7",              :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_7"
    t.string   "medical_history_previous_illnesses_illness_8",              :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_8"
    t.string   "medical_history_previous_illnesses_illness_9",              :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_9"
    t.string   "medical_history_previous_illnesses_illness_10",             :limit => 50
    t.date     "medical_history_previous_illnesses_diagnosis_10"
    t.integer  "family_history_mother_age"
    t.string   "family_history_mother_living_or_deceased",                  :limit => 25
    t.integer  "family_history_father_age"
    t.string   "family_history_father_living_or_deceased",                  :limit => 25
    t.string   "family_history_illnesses_mother_illness_1",                 :limit => 50
    t.integer  "family_history_illnesses_mother_age_at_diagnosis_1"
    t.string   "family_history_illnesses_mother_illness_2",                 :limit => 50
    t.integer  "family_history_illnesses_mother_age_at_diagnosis_2"
    t.string   "family_history_illnesses_mother_illness_3",                 :limit => 50
    t.integer  "family_history_illnesses_mother_age_at_diagnosis_3"
    t.string   "family_history_illnesses_father_illness_1",                 :limit => 50
    t.integer  "family_history_illnesses_father_age_at_diagnosis_1"
    t.string   "family_history_illnesses_father_illness_2",                 :limit => 50
    t.integer  "family_history_illnesses_father_age_at_diagnosis_2"
    t.string   "family_history_illnesses_father_illness_3",                 :limit => 50
    t.integer  "family_history_illnesses_father_age_at_diagnosis_3"
    t.string   "family_history_siblings_1",                                 :limit => 25
    t.string   "family_history_siblings_living_deceased_1",                 :limit => 25
    t.integer  "family_history_siblings_age_1"
    t.string   "family_history_siblings_1_illness_1",                       :limit => 50
    t.string   "family_history_siblings_1_age_at_diagnosis_1",              :limit => 50
    t.string   "family_history_siblings_1_illness_2",                       :limit => 50
    t.string   "family_history_siblings_1_age_at_diagnosis_2",              :limit => 50
    t.string   "family_history_siblings_2",                                 :limit => 25
    t.string   "family_history_siblings_living_deceased_2",                 :limit => 25
    t.integer  "family_history_siblings_age_2"
    t.string   "family_history_siblings_2_illness_1",                       :limit => 50
    t.string   "family_history_siblings_2_age_at_diagnosis_1",              :limit => 50
    t.string   "family_history_siblings_2_illness_2",                       :limit => 50
    t.string   "family_history_siblings_2_age_at_diagnosis_2",              :limit => 50
    t.string   "family_history_siblings_3",                                 :limit => 25
    t.string   "family_history_siblings_living_deceased_3",                 :limit => 25
    t.integer  "family_history_siblings_age_3"
    t.string   "family_history_siblings_3_illness_1",                       :limit => 50
    t.string   "family_history_siblings_3_age_at_diagnosis_1",              :limit => 50
    t.string   "family_history_siblings_3_illness_2",                       :limit => 50
    t.string   "family_history_siblings_3_age_at_diagnosis_2",              :limit => 50
    t.string   "social_history_live",                                       :limit => 15
    t.string   "social_history_live_with_whom",                             :limit => 50
    t.integer  "social_history_no_of_children"
    t.string   "social_history_age_of_children",                            :limit => 15
    t.string   "social_history_exercise_approximately",                     :limit => 50
    t.integer  "social_history_ex_minutes_per_day"
    t.string   "social_history_exercise_type",                              :limit => 50
    t.string   "social_history_hobbies",                                    :limit => 50
    t.string   "social_history_smoking_tobacco",                            :limit => 50
    t.integer  "social_history_smoking_packs_per_day"
    t.string   "social_history_smoking_no_of_years",                        :limit => 50
    t.string   "social_history_smoking_quit_years",                         :limit => 50
    t.integer  "social_history_drink"
    t.string   "social_history_drink_alcoholic_beverage",                   :limit => 25
    t.string   "social_history_have_used_recreational_drugs",               :limit => 25
    t.string   "social_history_yes_i_have_used_recreational_drugs",         :limit => 50
    t.string   "social_history_have_recently_traveled",                     :limit => 25
    t.string   "social_history_yes_i_recently_traveled",                    :limit => 50
    t.boolean  "review_of_sym_general_fatigue"
    t.boolean  "review_of_sym_general_fever"
    t.boolean  "review_of_sym_general_night_sweats"
    t.boolean  "review_of_sym_general_heat_or_cold"
    t.string   "review_of_sym_i_have",                                      :limit => 25
    t.string   "review_of_sym_i_have_many_pounds",                          :limit => 25
    t.string   "review_of_sym_i_have_time_periods",                         :limit => 25
    t.boolean  "review_of_sym_skin_rash"
    t.boolean  "review_of_sym_skin_hair_loss"
    t.boolean  "review_of_sym_skin_easy_bruising"
    t.boolean  "review_of_sym_skin_toenail_inflection"
    t.boolean  "review_of_sym_eye_redness"
    t.boolean  "review_of_sym_eye_pain"
    t.boolean  "review_of_sym_eye_discharge"
    t.boolean  "review_of_sym_eye_dryness"
    t.boolean  "review_of_sym_eye_visual_changes"
    t.boolean  "review_of_sym_nose_bleed"
    t.boolean  "review_of_sym_nose_nasal_discharge"
    t.boolean  "review_of_sym_nose_sinus_pain"
    t.boolean  "review_of_sym_nose_sinus_congestion"
    t.boolean  "review_of_sym_mouth_oral_lesions"
    t.boolean  "review_of_sym_mouth_white_patches"
    t.boolean  "review_of_sym_mouth_bleeding_gums"
    t.boolean  "review_of_sym_mouth_toothache"
    t.boolean  "review_of_sym_throat_hoarseness"
    t.boolean  "review_of_sym_throat_sore_throat"
    t.boolean  "review_of_sym_throat_pain_with_swallowing"
    t.boolean  "review_of_sym_throat_difficultly_swallowing"
    t.boolean  "review_of_sym_respiratory_cough"
    t.boolean  "review_of_sym_respiratory_coughing_blood"
    t.boolean  "review_of_sym_respiratory_shortness_of_breath_at_rest"
    t.boolean  "review_of_sym_respiratory_shortness_of_breath_on_exertion"
    t.boolean  "review_of_sym_respiratory_wheezing"
    t.boolean  "review_of_sym_cardiovascular_chest_discomfort"
    t.boolean  "review_of_sym_cardiovascular_palpitations"
    t.boolean  "review_of_sym_cardiovascular_ankle_swelling"
    t.boolean  "review_of_sym_cardiovascular_fast_heart_beat"
    t.boolean  "review_of_sym_cardiovascular_difficulty_breathing"
    t.boolean  "review_of_sym_cardiovascular_awakening_short_of_breath"
    t.boolean  "review_of_sym_urinary_pain_with_urination"
    t.boolean  "review_of_sym_urinary_urinating_frequently"
    t.boolean  "review_of_sym_urinary_incontinence"
    t.boolean  "review_of_sym_urinary_urinating_before_bathroom"
    t.boolean  "review_of_sym_urinary_urination_at_night"
    t.boolean  "review_of_sym_urinary_difficulty_starting_a_urine_stream"
    t.boolean  "review_of_sym_urinary_blood_in_urine"
    t.boolean  "review_of_sym_gastrointestinal_nausea"
    t.boolean  "review_of_sym_gastrointestinal_diarrhea"
    t.boolean  "review_of_sym_gastrointestinal_blood_in_the_stool"
    t.boolean  "review_of_sym_gastrointestinal_black_tarry_stool"
    t.boolean  "review_of_sym_gastrointestinal_heartburn"
    t.boolean  "review_of_sym_gastrointestinal_constipation"
    t.boolean  "review_of_sym_sexual_decreased_libido"
    t.boolean  "review_of_sym_sexual_difficulty_achieving_and_maintaining"
    t.boolean  "review_of_sym_musculoskeletal_joint_pain_or_stiffness"
    t.boolean  "review_of_sym_musculoskeletal_joint_swelling_or_redness"
    t.boolean  "review_of_sym_musculoskeletal_back_pain"
    t.boolean  "review_of_sym_musculoskeletal_muscle_pain"
    t.string   "review_of_sym_joints_that_are_painful_or_stiff",            :limit => 50
    t.string   "review_of_sym_joints_that_are_swelling_or_have_redness",    :limit => 50
    t.boolean  "review_of_sym_neurological_difficulty_with_memory"
    t.boolean  "review_of_sym_neurological_fainting"
    t.boolean  "review_of_sym_neurological_weakness"
    t.string   "review_of_sym_neurological_weakness_which_part_of_body",    :limit => 50
    t.boolean  "review_of_sym_neurological_seizures"
    t.boolean  "review_of_sym_neurological_severe_or_frequent_headaches"
    t.boolean  "review_of_sym_neurological_difficulty_with_balance"
    t.boolean  "review_of_sym_neurological_difficulty_walking"
    t.boolean  "review_of_sym_neurological_lightheadedness"
    t.boolean  "review_of_sym_neurological_vertigo"
    t.boolean  "review_of_sym_psychological_depression"
    t.boolean  "review_of_sym_psychological_lack_of_interest"
    t.boolean  "review_of_sym_psychological_decreased_sense_of_self_worth"
    t.boolean  "review_of_sym_psychological_difficulty_focusing"
    t.boolean  "review_of_sym_psychological_desire_to_end_your_life"
    t.boolean  "review_of_sym_psychological_disabling_anxiety"
    t.boolean  "review_of_sym_psychological_panic_attacks"
    t.boolean  "review_of_sym_sleep_difficulty_getting_to_sleep"
    t.boolean  "review_of_sym_sleep_difficulty_difficulty_staying_asleep"
    t.boolean  "review_of_sym_sleep_difficulty_snoring"
    t.boolean  "review_of_sym_sleep_difficulty_cessation_of_breathing"
    t.date     "health_maintenance_bone_density_test"
    t.date     "health_maintenance_skin_cancer_screening"
    t.date     "health_maintenance_test_date"
    t.string   "health_maintenance_total_cholesterol",                      :limit => 50
    t.string   "health_maintenance_LDL",                                    :limit => 50
    t.string   "health_maintenance_HDL",                                    :limit => 50
    t.string   "health_maintenance_triglycerides",                          :limit => 50
    t.date     "health_maintenance_most_recent_tetanus_vaccine_booster"
    t.date     "health_maintenance_shingles_vaccine"
    t.date     "health_maintenance_pneumovax"
    t.date     "health_maintenance_flu_vaccine"
    t.date     "health_maintenance_colonoscopy"
    t.string   "health_maintenance_colonoscopy_test_results",               :limit => 25
    t.string   "health_maintenance_description_of_abnormal_test_results",   :limit => 50
    t.date     "health_maintenance_most_recent_mammogram"
    t.date     "health_maintenance_most_recent_pap_smear"
    t.date     "health_maintenance_abnormal_pap_smear"
    t.date     "health_maintenance_hysterectomy"
    t.string   "health_maintenance_why_was_hysterectomy_performed",         :limit => 50
    t.date     "health_maintenance_digital_rectal_exam_and_psa_checked"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
  end

  create_table "patients", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pdfuploads", :force => true do |t|
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "role"
    t.string   "description"
    t.boolean  "disabled",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "service_providers", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.boolean  "status",                  :default => true
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "mapping_field_name"
    t.string   "form_pdf_path"
    t.string   "read_only_form_pdf_path"
  end

  create_table "sessionstores", :force => true do |t|
    t.string   "useremail_beforeupdate", :null => false
    t.string   "useremail_afterupdate",  :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "static_data", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.string   "data_type"
    t.integer  "data_order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.boolean  "deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_service_providers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "service_provider_id"
    t.boolean  "status",              :default => true
    t.date     "expiry_date"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",        :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",        :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.string   "password_salt"
    t.string   "role",                                  :default => "patient", :null => false
    t.string   "username"
    t.string   "edit_confirmed"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

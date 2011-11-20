class CreateIforms < ActiveRecord::Migration
  def self.up
    create_table :iforms do |t|
      t.string :Self_Email_Address, :limit => 50
      t.string :Self_Name_First, :limit => 50
      t.string :Self_Name_Honorific, :limit => 50
      t.string :Self_Name_Middle, :limit => 50
      t.string :Self_Prefix, :limit => 50
      t.string :Self_Name_Preferred, :limit => 50
      t.string :Self_Sex, :limit => 1
      t.integer :Self_Age
      t.string :Self_Social_Security_Number, :limit => 10
      t.string :Self_Home_Address1, :limit =>100
      t.string :Self_Home_Address2, :limit =>100
      t.string :Self_Home_City, :limit => 50
      t.string :Self_Home_State, :limit => 25
      t.string :Self_Home_Postal_Code, :limit => 10
      t.string :Self_Marital_Status, :limit => 10
      t.string :Self_Phone_Home, :limit => 15
      t.string :Self_Phone_Mobile, :limit => 15
      t.string :Self_Phone_Work, :limit => 15
      t.integer :Self_Phone_Work_Extension, :limit => 10
      t.string :Self_Driver_License_Number, :limit => 15
      t.string :Self_Employer_Name, :limit => 25
      t.string :Self_Employer_Address1,:limit => 50
      t.string :Self_Employer_Address2, :limit => 50
      t.string :Self_Employer_City,:limit => 20
      t.string :Self_Employer_State, :limit => 20
      t.string :Self_Employer_Postal_Code, :limit => 5
      t.string :Self_Length_Of_Employment, :limit => 25
      t.string :Self_Occupation, :limit => 50
      t.string :Self_General_Dentist_Name, :limit => 50
      t.string :Self_Referred_By, :limit => 50
      t.string :Self_Other_Family_Members, :limit => 50
      t.string :Self_Best_Contact_Method, :limit => 50
      t.string :Self_Best_Contact_Time
      t.date :Todays_Date
      t.date :Self_Birthdate
      t.date :Self_General_Dentist_Date_Last_Appointment
     # Spouce information
      t.string :Spouse_Name_First, :limit => 50
      t.string :Spouse_Name_Last, :limit => 50
      t.string :Spouse_Employer_Name, :limit => 50
      t.string :Spouse_Phone_Work, :limit => 10
      t.string :Spouse_Social_Security_Number, :limit => 10
      t.integer :Spouse_Phone_Work_Extension
      t.date :Spouse_Birthdate
      t.string :Person_Responsible_For_Account_Name_First, :limit => 50
      t.string :Person_Responsible_For_Account_Name_Last, :limit => 50
      t.string :Person_Responsible_For_Account_Phone_Work, :limit => 10
      t.integer :Person_Responsible_For_Account_Phone_Work_Extension
      t.string :Person_Responsible_For_Account_Phone_Home, :limit => 10
      t.string :Person_Responsible_For_Account_Employer_Name, :limit => 15
      t.string :Person_Responsible_For_Account_Social_Security_Number, :limit => 10
      t.string :Person_Responsible_For_Account_Address1, :limit =>100
      t.string :Person_Responsible_For_Account_Address2, :limit =>100
      t.string :Person_Responsible_For_Account_City, :limit => 20
      t.string :Person_Responsible_For_Account_State, :limit => 20
      t.string :Person_Responsible_For_Account_Postal_Code, :limit => 20
      t.string :Person_Responsible_For_Account_Relationship, :limit => 50
      t.string :Person_Responsible_For_Account_Drivers_License, :limit => 15
     # Orthodontic insurance
      t.boolean :Insurance_Company_Primary_Orthodontic_Coverage
      t.boolean :Insurance_Company_Primary_Dental_Coverage
      t.string :Insurance_Company_Primary_Name, :limit => 50
      t.string :Insurance_Company_Primary_Address1, :limit =>100
      t.string :Insurance_Company_Primary_Address2, :limit =>100
      t.string :Insurance_Company_Primary_City, :limit => 20
      t.string :Insurance_Company_Primary_State, :limit => 20
      t.string :Insurance_Company_Primary_Postal_Code, :limit => 5
      t.string :Insurance_Company_Primary_Phone, :limit => 10
      t.string :Insurance_Company_Primary_Group_Plan_Local_Policy_Number, :limit => 50
      t.string :Insurance_Company_Primary_Insured_Name_First, :limit => 50
      t.string :Insurance_Company_Primary_Insured_Name_Last, :limit => 50
      t.string :Insurance_Company_Primary_Insured_Relationship, :limit => 20
      t.date :Insurance_Company_Primary_Insured_Birthdate
      t.string :Insurance_Company_Primary_Insured_Social_Security_Number, :limit => 10
      t.string :Insurance_Company_Primary_Insured_Employer_Name, :limit => 50
      t.boolean :Insurance_Company_Secondary_Orthodontic_Coverage
      t.boolean :Insurance_Company_Secondary_Dental_Coverage
      t.string :Insurance_Company_Secondary_Name, :limit => 50
       t.string :Insurance_Company_Secondary_Address1, :limit =>100
       t.string :Insurance_Company_Secondary_Address2, :limit =>100
        t.string :Insurance_Company_Secondary_City, :limit => 20
        t.string :Insurance_Company_Secondary_State, :limit => 20
        t.string :Insurance_Company_Secondary_Postal_Code, :limit => 5
        t.string :Insurance_Company_Secondary_Phone, :limit => 10
        t.string :Insurance_Company_Secondary_Group_Plan_Local_Policy_Number, :limit => 50
        t.string :Insurance_Company_Secondary_Insured_Name_First, :limit => 50
        t.string :Insurance_Company_Secondary_Insured_Name_Last, :limit => 50
        t.string :Insurance_Company_Secondary_Insured_Relationship, :limit => 50
        t.date :Insurance_Company_Secondary_Insured_Birthdate
        t.string :Insurance_Company_Secondary_Insured_Social_Security_Number, :limit => 50
        t.string :Insurance_Company_Secondary_Insured_Employer_Name, :limit => 50
      t.string :Emergency_Contact_Name_First, :limit => 50
      t.string :Emergency_Contact_Name_Last, :limit => 50
      t.string :Emergency_Contact_Relationship, :limit => 50
      t.string :Emergency_Contact_Phone_Work, :limit => 15
      t.string :Emergency_Contact_Phone_Home, :limit => 15
     # Medical history 
      t.boolean :Med_His_Do_You_Have_Personal_Physician
      t.string :Med_His_Personal_Physician_Name_First, :limit => 50
      t.string :Med_His_Personal_Physician_Name_Last, :limit => 50
      t.string :Med_His_Personal_Physician_Phone, :limit => 15
      t.date :Med_His_Personal_Physician_Date_Of_Last_Visit
      t.string :Med_His_Current_Physical_Health, :limit => 5
      t.boolean :Med_His_Currently_Under_The_Care_Of_A_Physician
      t.string :Med_His_Currently_Under_The_Care_Of_A_Physician_Desc
      t.boolean :Med_His_Currently_Taking_Presc_Or_Over_The_Counter_Drugs
      t.string :Med_His_Currently_Taking_Presc_Or_Over_The_Counter_Drugs_List
      t.boolean :Med_His_Currently_Taking_Birth_Control_Pills
      t.boolean :Med_His_Currently_Pregnant
      t.string :Med_His_Weeks_Pregnant, :limit => 20
      t.boolean :Med_His_Currently_Nursing
      t.boolean :Med_His_Abnormal_Bleeding
      t.boolean :Med_His_Anemia
      t.boolean :Med_His_Artificial_Bones_Joints_Valves
      t.boolean :Med_His_Asthma
      t.boolean :Med_His_Blood_Transfusion
      t.boolean :Med_His_Cancer
      t.boolean :Med_His_Congenital_Heart_Defect
      t.boolean :Med_His_Diabetes
      t.boolean :Med_His_Difficulty_Breathing
      t.boolean :Med_His_Drug_Abuse
      t.boolean :Med_His_Emphysema
      t.boolean :Med_His_Epilepsy
      t.boolean :Med_His_Fever_Blisters
      t.boolean :Med_His_Glaucoma
      t.boolean :Med_His_Heart_Attack_Or_Stroke
      t.boolean :Med_His_Heart_Murmur
      t.boolean :Med_His_Heart_Surgery_Or_Pacemaker
      t.boolean :Med_His_Hemophilia
      t.boolean :Med_His_Hepatitis
      t.boolean :Med_His_High_Or_Low_Blood_Pressure
      t.boolean :Med_His_AIDS
      t.boolean :Med_His_Hospitalized_For_Any_Reason
      t.boolean :Med_His_Kidney_Problems
      t.boolean :Med_His_Mitral_Valve_Prolapse
      t.boolean :Med_His_Psychiatric_Problems
      t.boolean :Med_His_Radiation_Treatment
      t.boolean :Med_His_Rheumatic_Fever_Or_Scarletfever
      t.boolean :Med_His_Frequent_Headaches
      t.boolean :Med_His_Shingles
      t.boolean :Med_His_Sickle_Cell_Disease_Or_Traits
      t.boolean :Med_His_Sinus_Problems
      t.boolean :Med_His_Tuberculosis
      t.boolean :Med_His_Ulcers
      t.boolean :Med_His_Venereal_Disease
      t.string :Med_His_Serious_Medical_Issues
      t.boolean :Allergic_To_Aspirin
      t.boolean :Allergic_To_Metals_Or_Plastics
      t.boolean :Allergic_To_Codeine
      t.boolean :Allergic_To_Dental_Anesthetics
      t.boolean :Allergic_To_Erythromycin
      t.boolean :Allergic_To_Latex
      t.boolean :Allergic_To_Penicillin
      t.boolean :Allergic_To_Tetracycline
      t.boolean :Allergic_To_Other
      t.string :Allergic_To_Other_Detail
    # Dental history
      t.string :Dental_History_Concerns_Tobe_Accomplished_By_Orthodontics
      t.boolean :Dental_History_Previous_Orthodontic_Evaluation
      t.boolean :Dental_History_Previous_Dental_Work_Issues
      t.boolean :Dental_History_TMJ_TMD_Issues
      t.string :Dental_History_Current_Dental_Health, :limit => 5
      t.string :Dental_History_Injury_To_Chin, :limit =>6
      t.string :Dental_History_Injury_To_Teeth, :limit =>6
      t.string :Dental_History_Injury_To_Mouth, :limit =>6
      t.boolean :Dental_History_Like_Smile
      t.boolean :Dental_History_Bleeding_Gums
      t.boolean :Dental_History_Currently_Have_Speech_Problems
      t.boolean :Dental_History_Breath_Through_Mouth
      t.string :Dental_History_Breath_Through_Mouth_While_Awake, :limit => 10
      t.string :Dental_History_Breath_Through_Mouth_While_Sleep, :limit => 10
      t.boolean :Dental_History_Any_Extra_Permanent_Teeth
      t.boolean :Dental_History_Ever_Taken_PhenFen_Redux_Pondimin
      t.string :Dental_History_When_Taken_PhenFen_Redux_Pondimin, :limit => 50 
      t.boolean :Dental_History_Tobacco_Smoke
      t.string :path
      t.references :appointment
      t.timestamps
    end
  end

  def self.down
    drop_table :iforms
  end
end

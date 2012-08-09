class CreateChildforms < ActiveRecord::Migration
  def self.up
    create_table :childforms do |t|

      t.boolean :Accompanying_Your_Child_Today_Has_Legal_Custody_Of_Child
      t.string :Accompanying_Your_Child_Today_Relationship, :limit => 20
      t.string :Accompanying_Your_Child_Today_Siblings_And_Ages, :limit => 100
      t.string :Accompanying_Your_Child_Today_Name_First, :limit =>50
      t.string :Accompanying_Your_Child_Today_Name_Last, :limit =>50
      t.boolean :Allergic_To_Any_Drugs
      t.string :Allergic_To_Any_Drugs_List, :limit => 100
      t.boolean :Allergic_To_Latex
      t.boolean :Allergic_To_Metals
      t.boolean :Allergic_To_Plastics
      t.date :Date_Time_Form_Submitted_By_Consumer_To_Service_Provider
      t.boolean :Dental_History_Any_Extra_Permanent_Teeth
      t.boolean :Dental_History_Any_Missing_Teeth
      t.boolean :Dental_History_Brush_Teeth_Daily
      t.boolean :Dental_History_Floss_Teeth_Daily
      t.boolean :Dental_History_Injury_To_Chin
      t.boolean :Dental_History_Injury_To_Face
      t.boolean :Dental_History_Injury_To_Mouth
      t.boolean :Dental_History_Injury_To_Teeth
      t.string :Dental_History_Orthodontic_Goals
      t.string :Dental_History_Play_Musical_Instruments, :limit => 100
      t.boolean :Dental_History_Previous_Orthodontic_Evaluation
      t.boolean :Dental_History_Previous_Orthodontic_Treatment
      t.boolean :Dental_History_TMJ_TMD_Issues_Current
      t.boolean :Dental_History_TMJ_TMD_Issues_Previous
      t.boolean :Dental_History_Tonsils_Removed
      t.string :Father_Drivers_License_Number, :limit => 10
      t.string :Father_Drivers_License_State, :limit => 15
      t.string :Father_Employer_Name, :limit => 50
      t.string :Father_Job_Title, :limit => 50
      t.string :Father_Length_Of_Employment, :limit => 20
      t.string :Father_Name_First, :limit => 50
      t.string :Father_Name_Last, :limit => 50
      t.string :Father_Name_Middle, :limit => 50
      t.string :Father_Phone_Home, :limit => 10
      t.date :Father_Birthdate
      t.string :Father_Phone_Work, :limit => 10
      t.integer :Father_Phone_Work_Extension
      t.string :Father_Social_Security_Number, :limit => 10
      t.string :Father_Stepfather_Or_Gaurdian, :limit => 10
      t.boolean :Habits_Bottle
      t.boolean :Habits_Breast_Fed
      t.boolean :Habits_Clenching_Or_Grinding_Teeth
      t.boolean :Habits_Lip_Sucking_Or_Biting
      t.boolean :Habits_Mouth_Breather
      t.boolean :Habits_Nail_Biting
      t.boolean :Habits_Nursing
      t.boolean :Habits_Speech_Problems
      t.boolean :Habits_Thumb_Or_Finger_Sucking
      t.boolean :Habits_Tongue_Thrust
      t.string :Insurance_Company_Primary_Address1, :limit => 100
      t.string :Insurance_Company_Primary_Address2, :limit => 100
      t.string :Insurance_Company_Primary_City, :limit => 20
      t.boolean :Insurance_Company_Primary_Dental_Coverage
      t.string :Insurance_Company_Primary_Group_Plan_Local_Policy_Number, :limit => 50
      t.date :Insurance_Company_Primary_Insured_Birthdate
      t.string :Insurance_Company_Primary_Insured_Employer_Name, :limit => 50
      t.string :Insurance_Company_Primary_Insured_Name_First, :limit => 50
      t.string :Insurance_Company_Primary_Insured_Name_Last, :limit => 50
      t.string :Insurance_Company_Primary_Insured_Relationship, :limit => 20
      t.string :Insurance_Company_Primary_Insured_Social_Security_Number, :limit => 10
      t.string :Insurance_Company_Primary_Name, :limit => 50
      t.boolean :Insurance_Company_Primary_Orthodontic_Coverage
      t.string :Insurance_Company_Primary_Phone, :limit => 10
      t.string :Insurance_Company_Primary_Postal_Code, :limit => 5
      t.string :Insurance_Company_Primary_State, :limit => 15
      t.string :Insurance_Company_Secondary_Address1, :limit => 100
      t.string :Insurance_Company_Secondary_Address2, :limit => 100
      t.string :Insurance_Company_Secondary_City, :limit => 20
      t.boolean :Insurance_Company_Secondary_Dental_Coverage
      t.string :Insurance_Company_Secondary_Group_Plan_Local_Policy_Number, :limit => 50
      t.date :Insurance_Company_Secondary_Insured_Birthdate
      t.string :Insurance_Company_Secondary_Insured_Employer_Name, :limit => 50
      t.string :Insurance_Company_Secondary_Insured_Name_First, :limit => 50
      t.string :Insurance_Company_Secondary_Insured_Name_Last, :limit => 50
      t.string :Insurance_Company_Secondary_Insured_Relationship, :limit => 20
      t.string :Insurance_Company_Secondary_Insured_Social_Security_Number, :limit => 10
      t.string :Insurance_Company_Secondary_Name, :limit => 50
      t.boolean :Insurance_Company_Secondary_Orthodontic_Coverage
      t.string :Insurance_Company_Secondary_Phone, :limit => 10
      t.string :Insurance_Company_Secondary_Postal_Code, :limit => 5
      t.string :Insurance_Company_Secondary_State, :limit => 15
      t.boolean :Med_His_Abnormal_Bleeding
      t.boolean :Med_His_ADD
      t.boolean :Med_His_ADHD
      t.boolean :Med_His_AIDS
      t.boolean :Med_His_Any_Operations
      t.boolean :Med_His_Artificial_Bones_Joints_Valves
      t.boolean :Med_His_Asthma
      t.boolean :Med_His_Cancer
      t.boolean :Med_His_Congenital_Heart_Defect
      t.boolean :Med_His_Current_Physical_Health
      t.string :Med_His_Currently_Taking_Over_The_Counter_Drugs_List, :limit => 100
      t.string :Med_His_Currently_Taking_Presc_Drugs_List, :limit => 100
      t.boolean :Med_His_Currently_Under_The_Care_Of_A_Physician
      t.boolean :Med_His_Diabetes
      t.boolean :Med_His_Epilepsy
      t.boolean :Med_His_Handicaps_Or_Disabilities
      t.boolean :Med_His_Hearing_Impairment
      t.boolean :Med_His_Heart_Murmur
      t.boolean :Med_His_Hemophilia
      t.boolean :Med_His_Hepatitis
      t.boolean :Med_His_HIV_Positive
      t.boolean :Med_His_Hospitalized_For_Any_Reason
      t.boolean :Med_His_Kidney_Problems
      t.boolean :Med_His_Liver_Problems
      t.boolean :Med_His_Lupus
      t.string :Med_His_Medical_Problems
      t.boolean :Med_His_Menstruation_Begun
      t.date :Med_His_Personal_Physician_Date_Of_Last_Visit
      t.string :Med_His_Personal_Physician_Name_First
      t.string :Med_His_Personal_Physician_Name_Last
      t.string :Med_His_Personal_Physician_Phone
      t.boolean :Med_His_Puberty_Begun
      t.boolean :Med_His_Rheumatic_Fever
      t.boolean :Med_His_Scarlet_Fever
      t.boolean :Med_His_Sickle_Cell_Disease
      t.boolean :Med_His_Sickle_Cell_Disease_Traits
      t.boolean :Med_His_Tuberculosis
      t.string :Mother_Drivers_License_Number, :limit => 15
      t.string :Mother_Drivers_License_State, :limit => 15
      t.string :Mother_Employer_Name, :limit => 50
      t.string :Mother_Job_Title, :limit => 30
      t.string :Mother_Length_Of_Employment, :limit => 20
      t.string :Mother_Name_First, :limit => 50
      t.string :Mother_Name_Last, :limit => 50
      t.string :Mother_Name_Middle, :limit => 50
      t.date :Mother_Birthdate
      t.string :Mother_Phone_Home, :limit => 10
      t.string :Mother_Phone_Work, :limit => 10
      t.string :Mother_Phone_Work_Extension
      t.string :Mother_Social_Security_Number, :limit => 10
      t.string :Mother_Stepmother_Or_Gaurdian, :limit => 10
      t.string :Neighbor_Or_Relative_Not_Living_With_You_Address1, :limit => 100
      t.string :Neighbor_Or_Relative_Not_Living_With_You_Address2, :limit => 100
      t.string :Neighbor_Or_Relative_Not_Living_With_You_City, :limit => 20
      t.string :Neighbor_Or_Relative_Not_Living_With_You_Name_First, :limit => 50
      t.string :Neighbor_Or_Relative_Not_Living_With_You_Name_Last, :limit => 50
      t.string :Neighbor_Or_Relative_Not_Living_With_You_Name_Middle, :limit => 50
      t.string :Neighbor_Or_Relative_Not_Living_With_You_Phone, :limit => 10
      t.string :Neighbor_Or_Relative_Not_Living_With_You_Postal_Code, :limit => 5
      t.string :Neighbor_Or_Relative_Not_Living_With_You_State, :limit => 15
      t.string :Person_Responsible_For_Account_Address1, :limit => 100
      t.string :Person_Responsible_For_Account_Address2, :limit => 100
      t.string :Person_Responsible_For_Account_City, :limit => 20
      t.string :Person_Responsible_For_Account_Drivers_License_Number, :limit => 15
      t.string :Person_Responsible_For_Account_Drivers_License_State, :limit => 15
      t.string :Person_Responsible_For_Account_Employer_Name, :limit => 50
      t.string :Person_Responsible_For_Account_Name_First, :limit => 50
      t.string :Person_Responsible_For_Account_Name_Last, :limit => 50
      t.string :Person_Responsible_For_Account_Name_Middle, :limit => 50
      t.string :Person_Responsible_For_Account_Payment_Method, :limit => 15
      t.string :Person_Responsible_For_Account_Phone_Home, :limit => 10
      t.string :Person_Responsible_For_Account_Phone_Work, :limit => 10
      t.integer :Person_Responsible_For_Account_Phone_Work_Extension
      t.string :Person_Responsible_For_Account_Postal_Code, :limit => 5
      t.string :Person_Responsible_For_Account_Previous_Address1, :limit => 100
      t.string :Person_Responsible_For_Account_Previous_Address2, :limit => 100
      t.string :Person_Responsible_For_Account_Previous_City, :limit => 20
      t.string :Person_Responsible_For_Account_Previous_Postal_Code, :limit => 5
      t.string :Person_Responsible_For_Account_Previous_State, :limit => 15
      t.string :Person_Responsible_For_Account_Relationship, :limit => 20
      t.string :Person_Responsible_For_Account_Social_Security_Number, :limit => 10
      t.string :Person_Responsible_For_Account_State, :limit => 15
      t.string :Person_Responsible_For_Making_Appointments_Name_First, :limit => 50
      t.string :Person_Responsible_For_Making_Appointments_Name_Last, :limit => 50
      t.string :Person_Responsible_For_Making_Appointments_Name_Middle, :limit => 50
      t.string :Person_Responsible_For_Making_Appointments_Phone_Home, :limit => 10
      t.string :Person_Responsible_For_Making_Appointments_Phone_Work, :limit => 10
      t.integer :Person_Responsible_For_Making_Appointments_Phone_Work_Extension
      t.date :Self_Birthdate
      t.string :Self_Email_Address, :limit => 100
      t.date :Self_General_Dentist_Date_Last_Appointment
      t.string :Self_General_Dentist_Name, :limit => 50
      t.string :Self_Grade, :limit => 20
      t.string :Self_Hobbies, :limit => 100
      t.string :Self_Home_Address1, :limit => 100
      t.string :Self_Home_Address2, :limit => 100
      t.string :Self_Home_City, :limit => 20
      t.string :Self_Home_Postal_Code, :limit => 5
      t.string :Self_Home_State, :limit => 15
      t.string :Self_Marital_Status, :limit => 10
      t.string :Self_Name_First, :limit => 50
      t.string :Self_Name_Last, :limit => 50
      t.string :Self_Name_Middle, :limit => 50
      t.string :Self_Name_Preferred, :limit => 50
      t.string :Self_Phone_Home, :limit => 10
      t.string :Self_Referred_By, :limit => 20
      t.string :Self_School, :limit => 50
      t.string :Self_Sex, :limit => 6
      t.string :Self_Social_Security_Number, :limit => 10
       t.string :path
        t.string :formname, :limit => 50
        t.references :appointment

      t.timestamps
    end
  end

  def self.down
    drop_table :childforms
  end
end

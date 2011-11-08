class CreateIforms < ActiveRecord::Migration
  def self.up
    create_table :iforms do |t|
      t.string :email, :limit => 50
      t.string :firstname, :limit => 50
      t.string :lastname, :limit => 50
      t.string :middlename, :limit => 50
      t.string :prefix, :limit => 50
      t.string :preferredname, :limit => 50
      t.string :sex, :limit => 1
      t.integer :age
      t.string :SSN, :limit => 10
      t.string :homeadd
      t.string :city, :limit => 50
      t.string :state, :limit => 25
      t.string :zip, :limit => 10
      t.string :relationshipstatus, :limit => 10
      t.string :homeph, :limit => 15
      t.string :pager, :limit => 15
      t.string :workph, :limit => 15
      t.integer :workext, :limit => 10
      t.string :DL, :limit => 15
      t.string :employer, :limit => 25
      t.string :empadd
      t.string :empduration, :limit => 25
      t.string :occupation, :limit => 50
      t.string :generaldentist, :limit => 50
      t.string :personreferredyou, :limit => 50
      t.string :familyvisited, :limit => 50
      t.string :besttime_reachyou, :limit => 50
      t.date :todaydate
      t.date :birthdate
      t.date :lastvisitdate
      t.string :path
      t.string :spousename, :limit => 50
      t.string :spouse_employer, :limit => 50
      t.string :spouse_wkphone, :limit => 15
      t.string :spouse_SSN, :limit => 10
      t.integer :spouse_wkext
      t.date :spouse_birthdate
      t.string :responsibleperson_name, :limit => 50
      t.string :responsibleperson_wkph, :limit => 15
      t.string :responsibleperson_hmph, :limit => 15
      t.string :responsibleperson_employer, :limit => 15
      t.string :responsibleperson_SSN, :limit => 10
      t.string :responsibleperson_billingadd
      t.string :responsibleperson_relation, :limit => 50
      t.string :responsibleperson_DL, :limit => 15
      t.string :orthocoverage, :limit => 3
      t.string :dentalcoverage, :limit => 3
      t.string :insurancecompany, :limit => 50
      t.string :insurancecompany_add
      t.string :insurancecompany_ph, :limit => 15
      t.string :group, :limit => 50
      t.string :insureds_name, :limit => 50
      t.string :insureds_relation, :limit => 50
      t.date :insureds_birthdate
      t.string :insureds_SSN, :limit => 50
      t.string :insureds_employer, :limit => 50
      t.string :orthocoverage_sec, :limit => 3
      t.string :dentalcoverage_sec, :limit => 3
      t.string :insurancecompany_sec, :limit => 50
      t.string :insurancecompany_add_sec
      t.string :insurancecompany_ph_sec, :limit => 15
      t.string :group_sec, :limit => 50
      t.string :insureds_name_sec, :limit => 50
      t.string :insureds_relation_sec, :limit => 50
      t.date :insureds_birthdate_sec
      t.string :insureds_SSN_sec, :limit => 10
      t.string :insureds_employer_sec, :limit => 50
      t.string :emergencyperson_name, :limit => 50
      t.string :emergencyperson_relation, :limit => 50
      t.string :emergencyperson_wkph, :limit => 15
      t.string :emergencyperson_hmph, :limit => 15
      t.string :personalphysician, :limit => 50
      t.string :physicians_name, :limit => 50
      t.string :physicians_ph, :limit => 15
      t.date :physician_lastvisitdate
      t.string :current_physicalhealth, :limit => 5
      t.string :currently_underphysician, :limit => 5
      t.string :why_underphysician
      t.string :currently_underprescription, :limit => 5
      t.string :prescriptionlist
      t.string :birthcontrolpills, :limit => 5
      t.string :pregnant, :limit => 5
      t.string :pregnancyweek, :limit => 50
      t.string :nursing, :limit => 5
      t.string :abnormalbleeding, :limit => 1
      t.string :anemia, :limit => 1
      t.string :artificialbones_or_joints_or_valves, :limit => 1
      t.string :asthama_or_arthritis, :limit => 1
      t.string :bloodtransfusion, :limit => 1
      t.string :cancer_or_chemotherepy, :limit => 1
      t.string :congenital_heartdefect, :limit => 1
      t.string :diabetes, :limit => 1
      t.string :difficultybreathing, :limit => 1
      t.string :drug_or_alcoholabuse, :limit => 1
      t.string :emphysema, :limit => 1
      t.string :epilepsy_or_seizures_or_fainting, :limit => 1
      t.string :feverblisters_or_herpes, :limit => 1
      t.string :glaucoma, :limit => 1
      t.string :heartattack_or_stroke, :limit => 1
      t.string :heartmurmur, :limit => 1
      t.string :heartsurgery_or_pacemaker, :limit => 1
      t.string :hemophilia, :limit => 1
      t.string :hepatitis, :limit => 1
      t.string :high_or_lowbloodpressure, :limit => 1
      t.string :HIV_or_AIDS, :limit => 1
      t.string :hospitalized_reason, :limit => 1
      t.string :kidneyproblems, :limit => 1
      t.string :mitralvalveprolapse, :limit => 1
      t.string :psychiatricproblems, :limit => 1
      t.string :radiationtreatment, :limit => 1
      t.string :rheumatic_or_scarletfever, :limit => 1
      t.string :severe_or_frequentheadaches, :limit => 1
      t.string :shingles, :limit => 1
      t.string :sicklecelldisease_or_traits, :limit => 1
      t.string :sinusproblems, :limit => 1
      t.string :tuberculosis, :limit => 1
      t.string :ulcers_or_colitis, :limit => 1
      t.string :venerealdisease, :limit => 1
      t.string :serious_medicalconditions, :limit => 1
      t.string :aspirin, :limit => 1
      t.string :anymetals_or_plastics, :limit => 1
      t.string :codeine, :limit => 1
      t.string :dentalanesthetics, :limit => 1
      t.string :erythromycin, :limit => 1
      t.string :latex, :limit => 1
      t.string :penicillin, :limit => 1
      t.string :tetracycline, :limit => 1
      t.string :other, :limit => 1
      t.string :drugslist_allergicto
      t.string :concerns_accomplished_byorthodontics
      t.string :undogone_orthodontictreatment, :limit => 1
      t.string :problemwith_previousdentalwork, :limit => 1
      t.string :pain_jawjoint, :limit => 1
      t.string :current_dentalhealth, :limit => 5
      t.string :likeyoursmile, :limit => 1
      t.string :gumsbleed, :limit => 1
      t.string :speechproblems, :limit => 1
      t.string :breaththrumouth_awake_sleep, :limit => 1
      t.string :breaththrumouth, :limit => 1
      t.string :missing_or_extra_permanantteeth, :limit => 1
      t.string :evertaken_phenfen, :limit => 1
      t.string :when_phenfen, :limit => 1
      t.string :smoke_or_usetobacco, :limit => 1
      t.references :appointment
      t.timestamps
    end
  end

  def self.down
    drop_table :iforms
  end
end

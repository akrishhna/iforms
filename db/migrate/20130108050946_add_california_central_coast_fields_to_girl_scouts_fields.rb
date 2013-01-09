class AddCaliforniaCentralCoastFieldsToGirlScoutsFields < ActiveRecord::Migration

  def up
    add_column :girl_scouts_fields, :california_central_coast, :boolean

    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 1 Name', :california_central_coast => true})
    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 1 Driver', :california_central_coast => true})
    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 1 Registered', :california_central_coast => true})

    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 2 Name', :california_central_coast => true})
    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 2 Driver', :california_central_coast => true})
    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 2 Registered', :california_central_coast => true})

    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 3 Name', :california_central_coast => true})
    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 3 Driver', :california_central_coast => true})
    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 3 Registered', :california_central_coast => true})

    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 4 Name', :california_central_coast => true})
    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 4 Driver', :california_central_coast => true})
    GirlScoutsFields.create({:tab_name => 'Activity', :field_name => 'Chaperone 4 Registered', :california_central_coast => true})

    GirlScoutsFields.create({:tab_name => 'arent Permission', :field_name => 'Allergies', :california_central_coast => true})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent Name',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent Address',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent Home Phone',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent Work Phone',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent Mobile Phone',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent Other Phone',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent Email Address',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Medical Treatment Yes',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Medical Treatment No',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Publicity Photos Yes',:california_central_coast => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Publicity Photos No',:california_central_coast => true })

    fields = GirlScoutsFields.all
    fields.each do |f|
      f.california_central_coast = true if f.field_name == 'Activity Name'
      f.california_central_coast = true if f.field_name == 'Activity Location'
      f.central_southern = true if f.field_name == 'Activity Time'
      f.california_central_coast = true if f.field_name == 'Activity Start Date'
      f.california_central_coast = true if f.field_name == 'Activity End Date'
      f.california_central_coast = true if f.field_name == 'Signed Permission Forms Due Date'
      f.california_central_coast = true if f.field_name == 'We Will Leave From'
      f.california_central_coast = true if f.field_name == 'We Will Leave At'
      f.california_central_coast = true if f.field_name == 'We Will Return To'
      f.california_central_coast = true if f.field_name == 'We Will Return At'
      f.california_central_coast = true if f.field_name == 'Activity Cost'
      f.california_central_coast = true if f.field_name == 'Mode of Transportation'
      f.california_central_coast = true if f.field_name == 'Girls Should Bring'
      f.california_central_coast = true if f.field_name == 'Troop Number'
      f.california_central_coast = true if f.field_name == 'Troop Leader Name'
      f.california_central_coast = true if f.field_name == 'Troop Emergency Contact Name'
      f.california_central_coast = true if f.field_name == 'Troop Emergency Contact Phone Number'

      f.california_central_coast = true if f.field_name == 'Emergency Contact'
      f.california_central_coast = true if f.field_name == 'Emergency Contact Phone Number'
      f.california_central_coast = true if f.field_name == 'Emergency Contact Cell Number'
      f.california_central_coast = true if f.field_name == 'Address'
      f.california_central_coast = true if f.field_name == 'Relationship To Patient'
      f.california_central_coast = true if f.field_name == 'Medications'

      f.save(:validate => false)
    end
  end

  def down
    remove_column :girl_scouts_fields, :california_central_coast
  end
end

class AddCentralSouthernFieldsToGirlScoutsFields < ActiveRecord::Migration

  def up
    add_column :girl_scouts_fields, :central_southern, :boolean

    GirlScoutsFields.create({:tab_name => 'Troop', :field_name => 'Certified First Aider Not Needed', :central_southern => true})
    GirlScoutsFields.create({:tab_name => 'Troop', :field_name => 'Certified First Aider Provided', :central_southern => true})
    GirlScoutsFields.create({:tab_name => 'Troop', :field_name => 'First Aider Attending Name', :central_southern => true})
    GirlScoutsFields.create({:tab_name => 'Troop', :field_name => 'Certification Expiration Checked', :central_southern => true})


    fields = GirlScoutsFields.all
    fields.each do|f|
      f.central_southern = true if f.field_name == 'Activity Name'
      f.central_southern = true if f.field_name == 'Activity Location'
      f.central_southern = true if f.field_name == 'Activity Start Date'
      f.central_southern = true if f.field_name == 'Activity End Date'
      f.central_southern = true if f.field_name == 'Signed Permission Forms Due Date'
      f.central_southern = true if f.field_name == 'We Will Leave From'
      f.central_southern = true if f.field_name == 'We Will Leave At'
      f.central_southern = true if f.field_name == 'We Will Return To'
      f.central_southern = true if f.field_name == 'We Will Return At'
      f.central_southern = true if f.field_name == 'Activity Cost'
      f.central_southern = true if f.field_name == 'Equipment Needed'
      f.central_southern = true if f.field_name == 'Activity Time'
      f.central_southern = true if f.field_name == 'Adults Accompanying Girls'
      f.central_southern = true if f.field_name == 'Troop Number'
      f.central_southern = true if f.field_name == 'Troop Leader Name'
      f.central_southern = true if f.field_name == 'Troop Leader Phone'


      f.central_southern = true if f.field_name == 'Phone Number During Activity'
      f.central_southern = true if f.field_name == 'Authorize Behalf Address'
      f.central_southern = true if f.field_name == 'Emergency Contact'
      f.central_southern = true if f.field_name == 'Emergency Contact Phone Number'
      f.central_southern = true if f.field_name == 'Address'
      f.central_southern = true if f.field_name == 'Relationship To Patient'
      f.central_southern = true if f.field_name == 'Special Needs Medications Comments'

      f.save(:validate => false)
    end
  end

  def down
    remove_column :girl_scouts_fields, :central_southern
  end
end

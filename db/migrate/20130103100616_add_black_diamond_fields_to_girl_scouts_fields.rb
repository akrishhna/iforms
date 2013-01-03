class AddBlackDiamondFieldsToGirlScoutsFields < ActiveRecord::Migration

  def up
    add_column :girl_scouts_fields, :black_diamond, :boolean
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Additional Expenses',:black_diamond => true })
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Leaders Accompanying Girls',:black_diamond => true })

    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Activity My Behalf Phone Number',:black_diamond => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Activity My Behalf Relationship To Participant',:black_diamond => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Additional Remarks',:black_diamond => true })

    fields = GirlScoutsFields.all
    fields.each do|f|
      f.black_diamond = true if f.field_name == 'Activity Name'
      f.black_diamond = true if f.field_name == 'Activity Location'
      f.black_diamond = true if f.field_name == 'Activity Location Phone Number'
      f.black_diamond = true if f.field_name == 'Activity Start Date'
      f.black_diamond = true if f.field_name == 'Signed Permission Forms Due Date'
      f.black_diamond = true if f.field_name == 'We Will Leave From'
      f.black_diamond = true if f.field_name == 'We Will Leave At'
      f.black_diamond = true if f.field_name == 'We Will Return To'
      f.black_diamond = true if f.field_name == 'We Will Return At'
      f.black_diamond = true if f.field_name == 'Activity Cost'
      f.black_diamond = true if f.field_name == 'Troop Number'
      f.black_diamond = true if f.field_name == 'Troop Leader Name'
      f.black_diamond = true if f.field_name == 'Troop Leader Phone'
      f.black_diamond = true if f.field_name == 'Troop Emergency Contact Name'
      f.black_diamond = true if f.field_name == 'Troop Emergency Contact Phone Number'
      f.black_diamond = true if f.field_name == 'Equipment Needed'

      f.black_diamond = true if f.field_name == 'Authorize Behalf Name'
      f.black_diamond = true if f.field_name == 'Phone Number During Activity'
      f.black_diamond = true if f.field_name == 'Physician Name'
      f.black_diamond = true if f.field_name == 'Physician Phone'

      f.save(:validate => false)
    end
  end

  def down
    remove_column :girl_scouts_fields, :black_diamond
  end

end

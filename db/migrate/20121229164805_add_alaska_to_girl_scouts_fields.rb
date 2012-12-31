class AddAlaskaToGirlScoutsFields < ActiveRecord::Migration

  def up
    add_column :girl_scouts_fields, :alaska, :boolean

    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity Location Phone Number',:alaska => true })
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity Time',:alaska => true })
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Adults Accompanying Girls',:alaska => true })
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Troop Leader Phone',:alaska => true })
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Authorize Behalf Address',:alaska => true })

    fields = GirlScoutsFields.all
    fields.each do|f|
      f.alaska = true if f.field_name == 'Activity Name'
      f.alaska = true if f.field_name == 'Activity Location'
      f.alaska = true if f.field_name == 'Activity Start Date'
      f.alaska = true if f.field_name == 'Signed Permission Forms Due Date'
      f.alaska = true if f.field_name == 'We Will Leave From'
      f.alaska = true if f.field_name == 'We Will Leave At'
      f.alaska = true if f.field_name == 'We Will Return To'
      f.alaska = true if f.field_name == 'We Will Return At'
      f.alaska = true if f.field_name == 'Mode of Transportation'
      f.alaska = true if f.field_name == 'Girls Should Bring'
      f.alaska = true if f.field_name == 'Troop Number'
      f.alaska = true if f.field_name == 'Troop Leader Name'
      f.alaska = true if f.field_name == 'Troop Emergency Contact Name'
      f.alaska = true if f.field_name == 'Troop Emergency Contact Phone Number'

      f.alaska = true if f.field_name == 'Emergency Contact'
      f.alaska = true if f.field_name == 'Authorize Behalf Address'
      f.alaska = true if f.field_name == 'Phone Number During Activity'
      f.alaska = true if f.field_name == 'Relationship To Patient'
      f.alaska = true if f.field_name == 'Address'
      f.alaska = true if f.field_name == 'Physician Name'
      f.alaska = true if f.field_name == 'Physician Phone'
      f.alaska = true if f.field_name == 'Emergency Contact Phone Number'
       f.save(:validate => false)
    end

  end

  def down
    remove_column :girl_scouts_fields, :alaska
  end
end

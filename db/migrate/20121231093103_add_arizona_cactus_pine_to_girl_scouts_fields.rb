class AddArizonaCactusPineToGirlScoutsFields < ActiveRecord::Migration

  def up
    add_column :girl_scouts_fields, :arizona_cactus_pine, :boolean

    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity Start Time',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity End Time',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity Cost Used For',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Troop Emergency Contact',:field_name => 'Activity Will Involve Unusual Risk',:arizona_cactus_pine => true })

    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Changes To General Permission Slip',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Unusual Risk Acknowledgement',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Special Needs Medications Comments',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 1 Address',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 1 Home Phone',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 1 Work Phone',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 1 Mobile Phone',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 1 Other Phone',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 1 Email Address',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 2 Address',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 2 Home Phone',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 2 Work Phone',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 2 Mobile Phone',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 2 Other Phone',:arizona_cactus_pine => true })
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Parent 2 Email Address',:arizona_cactus_pine => true })


    fields = GirlScoutsFields.all
    fields.each do|f|
      f.arizona_cactus_pine = true if f.field_name == 'Activity Name'
      f.arizona_cactus_pine = true if f.field_name == 'Activity Location'
      f.arizona_cactus_pine = true if f.field_name == 'Activity Start Date'
      f.arizona_cactus_pine = true if f.field_name == 'Signed Permission Forms Due Date'
      f.arizona_cactus_pine = true if f.field_name == 'We Will Leave From'
      f.arizona_cactus_pine = true if f.field_name == 'We Will Leave At'
      f.arizona_cactus_pine = true if f.field_name == 'We Will Return To'
      f.arizona_cactus_pine = true if f.field_name == 'We Will Return At'
      f.arizona_cactus_pine = true if f.field_name == 'Activity Cost'
      f.arizona_cactus_pine = true if f.field_name == 'Mode of Transportation'
      f.arizona_cactus_pine = true if f.field_name == 'Adults Accompanying Girls'
      f.arizona_cactus_pine = true if f.field_name == 'Troop Number'
      f.arizona_cactus_pine = true if f.field_name == 'Troop Leader Name'
      f.arizona_cactus_pine = true if f.field_name == 'Troop Emergency Contact Name'
      f.arizona_cactus_pine = true if f.field_name == 'Troop Emergency Contact Phone Number'

      f.save(:validate => false)
    end
  end

  def down
    remove_column :girl_scouts_fields, :arizona_cactus_pine
  end

end

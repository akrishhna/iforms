class CreateGirlScoutsFields < ActiveRecord::Migration
  def self.up
    create_table :girl_scouts_fields do |t|
      t.string :tab_name
      t.string :field_name
      t.boolean :central_texas
      t.boolean :diamonds

      t.timestamps
    end

    # generating fields of central texas and diamonds
    GirlScoutsFields.create({:field_name => 'Form Name'})
    GirlScoutsFields.create({:field_name => 'Date Received'})
    GirlScoutsFields.create({:field_name => 'Date Submitted'})
    GirlScoutsFields.create({:field_name => 'Attending'})
    GirlScoutsFields.create({:field_name => 'Program Year Start',:central_texas => true, :diamonds => false})

    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity Name',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity Location',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity Start Date',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity End Date',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Signed Permission Forms Due Date',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'We Will Leave From',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'We Will Leave At',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'We Will Return To',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'We Will Return At',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Activity Cost',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Girls Should Wear Uniforms',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Girls Should Wear Other',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Girls Should Bring',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Mode of Transportation',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Activity',:field_name => 'Equipment Needed',:central_texas => true, :diamonds => true})

    GirlScoutsFields.create({:tab_name => 'Troop',:field_name => 'Service Unit',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Troop',:field_name => 'Troop Number',:central_texas => true, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Troop',:field_name => 'PAL',:central_texas => true, :diamonds => false})

    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader Name',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader Email Address',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader Day Phone',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader Evening Phone',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader Cell Phone',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader advisor 1 Name',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader advisor 1 Day Phone',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader advisor 1 Cell Phone',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader advisor 2 Name',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader advisor 2 Day Phone',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Troop Leader',:field_name => 'Troop Leader advisor 2 Cell Phone',:central_texas => false, :diamonds => true})


    GirlScoutsFields.create({:tab_name => 'Troop Emergency Contact',:field_name => 'Troop Emergency Name',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Troop Emergency Contact',:field_name => 'Troop Emergency Contact Name',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Troop Emergency Contact',:field_name => 'Troop Emergency Day Phone',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Troop Emergency Contact',:field_name => 'Troop Emergency Evening Phone',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Troop Emergency Contact',:field_name => 'Troop Emergency Contact Phone Number',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Troop Emergency Contact',:field_name => 'Troop Emergency Contact Cell Phone',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Troop Emergency Contact',:field_name => 'Troop Emergency Contact Address',:central_texas => false, :diamonds => true})

    # Permission Form Fields
     #central texas
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact 1',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact 1 Phone 1',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact 1 Phone 2',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact 2',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact 2 Phone 1',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact 2 Phone 2',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact 3',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact 3 Phone 1',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact 3 Phone 2',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Physician Name',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Physician Phone',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'My Insurance Carrier',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Policy Number',:central_texas => true, :diamonds => false})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Specific Needs',:central_texas => true, :diamonds => false})
     #diamonds
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Authorize Behalf Name',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Phone Number During Activity',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact Phone Number',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Emergency Contact Cell Number',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Address',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Relationship To Patient',:central_texas => false, :diamonds => true})
    GirlScoutsFields.create({:tab_name => 'Parent Permission',:field_name => 'Medications',:central_texas => false, :diamonds => true})
  end

  def self.down
    drop_table :girl_scouts_fields
  end
end

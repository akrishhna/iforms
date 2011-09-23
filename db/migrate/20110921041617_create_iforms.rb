class CreateIforms < ActiveRecord::Migration
  def self.up
    create_table :iforms do |t|
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :middlename
      t.string :prefix
      t.string :preferredname
      t.string :sex
      t.integer :age
      t.string :ssn
      t.string :homeadd
      t.string :city
      t.string :state
      t.string :zip
      t.string :relationshipstatus
      t.string :homeph
      t.string :pager
      t.string :workph
      t.string :workext
      t.string :license
      t.string :employer
      t.string :empadd
      t.string :empduration
      t.string :occupation
      t.string :generaldentist
      t.string :referal
      t.string :familyvisited
      t.string :reachyou
      t.date :todaydate
      t.date :birthdate
      t.date :lastvisitdate

      t.timestamps
    end
  end

  def self.down
    drop_table :iforms
  end
end

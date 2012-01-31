class CreateSessionstores < ActiveRecord::Migration
  def self.up
    create_table :sessionstores do |t|
      t.string :useremail_beforeupdate, :null => false
      t.string :useremail_afterupdate, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :sessionstores
  end
end

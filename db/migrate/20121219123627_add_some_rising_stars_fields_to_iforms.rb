class AddSomeRisingStarsFieldsToIforms < ActiveRecord::Migration
  def up
    add_column :iforms, :social_history_patient_is, :string, :limit => 20
  end
  def down
    remove_column :iforms, :social_history_patient_is
  end
end

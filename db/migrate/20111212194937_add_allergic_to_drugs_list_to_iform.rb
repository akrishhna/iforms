class AddAllergicToDrugsListToIform < ActiveRecord::Migration
  def self.up
    add_column :iforms, :Allergic_To_Drugs_List, :string
  end

  def self.down
    remove_column :iforms, :Allergic_To_Drugs_List
  end
end

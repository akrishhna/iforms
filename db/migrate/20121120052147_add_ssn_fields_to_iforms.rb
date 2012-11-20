class AddSsnFieldsToIforms < ActiveRecord::Migration

  def up
    add_column :iforms, :billing_details_ssn_1, :integer
    add_column :iforms, :billing_details_ssn_2, :integer
    add_column :iforms, :billing_details_ssn_3, :integer
  end
  def down
    remove_column :iforms, :billing_details_ssn_1
    remove_column :iforms, :billing_details_ssn_2
    remove_column :iforms, :billing_details_ssn_3
  end
end

class AddMappingFieldsToServiceProviders < ActiveRecord::Migration

  def up
    add_column :service_providers, :mapping_field_name, :string
    add_column :service_providers, :form_pdf_path, :string
    add_column :service_providers, :read_only_form_pdf_path, :string
  end

  def down
    remove_column :service_providers, :mapping_field_name
    remove_column :service_providers, :form_pdf_path
    remove_column :service_providers, :read_only_form_pdf_path
  end

end

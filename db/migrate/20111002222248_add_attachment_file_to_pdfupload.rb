class AddAttachmentFileToPdfupload < ActiveRecord::Migration
  def self.up
    add_column :pdfuploads, :file_file_name, :string
    add_column :pdfuploads, :file_content_type, :string
    add_column :pdfuploads, :file_file_size, :integer
    add_column :pdfuploads, :file_updated_at, :datetime
  end

  def self.down
    remove_column :pdfuploads, :file_file_name
    remove_column :pdfuploads, :file_content_type
    remove_column :pdfuploads, :file_file_size
    remove_column :pdfuploads, :file_updated_at
  end
end

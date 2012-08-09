class CreatePdfuploads < ActiveRecord::Migration
  def self.up
    create_table :pdfuploads do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :pdfuploads
  end
end

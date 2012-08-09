class CreateControls < ActiveRecord::Migration
  def self.up
    create_table :controls do |t|
      t.string :name
      t.string :controltype
      t.references :pdfupload

      t.timestamps
    end
  end

  def self.down
    drop_table :controls
  end
end

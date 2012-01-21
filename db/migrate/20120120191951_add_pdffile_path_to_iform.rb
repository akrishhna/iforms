class AddPdffilePathToIform < ActiveRecord::Migration
  def self.up
    add_column :iforms, :pdffile_path, :binary, :limit => 10.megabyte
  end

  def self.down
    remove_column :iforms, :pdffile_path
  end
end

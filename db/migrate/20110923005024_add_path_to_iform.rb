class AddPathToIform < ActiveRecord::Migration
  def self.up
    add_column :iforms, :path, :string
  end

  def self.down
    remove_column :iforms, :path
  end
end

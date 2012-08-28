class CreateGirlsScouts < ActiveRecord::Migration
  def change
    create_table :girls_scouts do |t|
      t.integer :user_id
      t.string :name
      t.string :parent_name
      t.string :email

      t.timestamps
    end
  end
end

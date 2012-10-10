class CreateDisplayMessages < ActiveRecord::Migration
  def change
    create_table :display_messages do |t|
      t.integer :user_id
      t.string  :message_type
      t.boolean :status

      t.timestamps
    end
  end
end

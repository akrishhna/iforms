class AddSpeechToIform < ActiveRecord::Migration
  def self.up
    add_column :iforms, :Dental_History_Habits_Speech_Problems, :string
  end

  def self.down
    remove_column :iforms, :Dental_History_Habits_Speech_Problems
  end
end

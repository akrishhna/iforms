class RemoveSpeechFromIform < ActiveRecord::Migration
  def self.up
    remove_column :iforms, :Dental_History_Habits_Speech_Problems
  end

  def self.down
    add_column :iforms, :Dental_History_Habits_Speech_Problems, :string
  end
end

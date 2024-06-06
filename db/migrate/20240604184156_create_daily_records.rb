class CreateDailyRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_records do |t|
      t.datetime :date
      t.integer :male_count
      t.integer :female_count

      t.timestamps
    end
  end
end

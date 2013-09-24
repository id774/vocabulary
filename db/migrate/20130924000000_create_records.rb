class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
  end
end

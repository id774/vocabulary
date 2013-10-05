class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :key
      t.string :tag
      t.string :value
    end
  end
end

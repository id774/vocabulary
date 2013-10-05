class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :json
    end
  end
end

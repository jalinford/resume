class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :category_id
      t.string :position
      t.string :organization
      t.string :location
      t.date :start_date
      t.date :end_date
      t.integer :priority

      t.timestamps
    end
  end
end

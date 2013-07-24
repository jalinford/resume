class CreateActivityHighlights < ActiveRecord::Migration
  def change
    create_table :activity_highlights do |t|
      t.integer :activity_id
      t.string :highlight
      t.integer :priority

      t.timestamps
    end
  end
end

class CreateActivityTags < ActiveRecord::Migration
  def change
    create_table :activity_tags do |t|
      t.integer :activity_highlight_id
      t.integer :tag_id

      t.timestamps
    end
  end
end

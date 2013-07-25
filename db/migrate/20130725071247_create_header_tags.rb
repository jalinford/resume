class CreateHeaderTags < ActiveRecord::Migration
  def change
    create_table :header_tags do |t|
      t.integer :header_id
      t.integer :tag_id

      t.timestamps
    end
  end
end

class CreateFooterTags < ActiveRecord::Migration
  def change
    create_table :footer_tags do |t|
      t.integer :footer_item_id
      t.integer :tag_id

      t.timestamps
    end
  end
end

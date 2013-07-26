class CreateFooterItems < ActiveRecord::Migration
  def change
    create_table :footer_items do |t|
      t.integer :footer_id
      t.string :item
      t.integer :priority

      t.timestamps
    end
  end
end

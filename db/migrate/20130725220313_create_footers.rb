class CreateFooters < ActiveRecord::Migration
  def change
    create_table :footers do |t|
      t.string :title
      t.integer :priority

      t.timestamps
    end
  end
end

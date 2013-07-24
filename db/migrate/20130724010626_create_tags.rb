class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.text :objective
      t.text :summary
      t.boolean :featured

      t.timestamps
    end
  end
end

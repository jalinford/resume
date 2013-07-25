class CreateHeaders < ActiveRecord::Migration
  def change
    create_table :headers do |t|
      t.string :title
      t.string :name
      t.string :email
      t.string :phone
      t.string :address_one
      t.string :address_two
      t.string :address_three
      t.boolean :default

      t.timestamps
    end
  end
end

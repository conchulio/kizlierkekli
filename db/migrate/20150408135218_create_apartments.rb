class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :title
      t.text :description
      t.integer :cost
      t.integer :deposit
      t.string :currency
      t.references :user, index: true
      t.integer :males, default: 0
      t.integer :females, default: 0
      t.string :address
      t.float :lat
      t.float :lng
      t.datetime :created_at
      t.date :from
      t.date :until
      t.string :phone
      t.string :male_or_female, default: 0

      t.timestamps null: false
    end
    add_foreign_key :apartments, :users
  end
end

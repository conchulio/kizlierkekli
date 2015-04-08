class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :title
      t.text :description
      t.decimal :cost
      t.decimal :deposit
      t.string :currency
      t.references :user, index: true
      t.integer :males
      t.integer :females
      t.string :address
      t.float :lat
      t.float :lng
      t.datetime :created_at
      t.date :from
      t.date :until
      t.string :phone
      t.string :male_or_female

      t.timestamps null: false
    end
    add_foreign_key :apartments, :users
  end
end

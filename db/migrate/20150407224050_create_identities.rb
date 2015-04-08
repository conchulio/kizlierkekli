class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :identities, :users
  end
end

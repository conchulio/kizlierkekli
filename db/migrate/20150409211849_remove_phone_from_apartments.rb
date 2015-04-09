class RemovePhoneFromApartments < ActiveRecord::Migration
  def change
    remove_column :apartments, :phone, :string
  end
end

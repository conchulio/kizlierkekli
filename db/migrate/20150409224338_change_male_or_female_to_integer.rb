class ChangeMaleOrFemaleToInteger < ActiveRecord::Migration
  def change
    remove_column :apartments, :male_or_female
    add_column :apartments, :male_or_female, :integer, default: 0
  end
end

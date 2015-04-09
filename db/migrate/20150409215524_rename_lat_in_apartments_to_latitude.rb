class RenameLatInApartmentsToLatitude < ActiveRecord::Migration
  def change
    rename_column :apartments, :lat, :latitude
  end
end

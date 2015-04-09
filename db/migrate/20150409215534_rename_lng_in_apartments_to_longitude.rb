class RenameLngInApartmentsToLongitude < ActiveRecord::Migration
  def change
    rename_column :apartments, :lng, :longitude
  end
end

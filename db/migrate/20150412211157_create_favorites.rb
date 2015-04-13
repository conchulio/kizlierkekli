class CreateFavorites < ActiveRecord::Migration
  def change
 
    create_table :favorites do |t|
      t.belongs_to :user, index: true
      t.belongs_to :apartment, index: true
      t.text :comment
    end
  end
end

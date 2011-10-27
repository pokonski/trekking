class AddSerializableLocationsToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :locations, :text
  end
end

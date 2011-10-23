class CreateWaypoints < ActiveRecord::Migration
  def change
    create_table :waypoints do |t|
      t.references :route
      t.string :description
      t.float :longitude
      t.float :latitude
      t.integer :order, :default => 0
      t.timestamps
    end
  end
end

class AddLatitudeLongitudeGmapsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :latitude, :float
    add_column :people, :longitude, :float
    add_column :people, :gmaps, :boolean
  end
end

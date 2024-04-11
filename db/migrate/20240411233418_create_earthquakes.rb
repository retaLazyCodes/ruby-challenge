class CreateEarthquakes < ActiveRecord::Migration[7.1]
  def change
    create_table :earthquakes do |t|
      t.string :custom_id
      t.float :magnitude
      t.string :place
      t.datetime :time
      t.string :url
      t.boolean :tsunami
      t.string :mag_type
      t.string :title
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end

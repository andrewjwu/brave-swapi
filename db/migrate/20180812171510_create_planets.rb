class CreatePlanets < ActiveRecord::Migration[5.2]
  def change
    create_table :planets do |t|
      t.integer :swapi_id
      t.string :name
      t.string :rotation_period
      t.string :orbital_period
      t.string :diameter
      t.string :climate
      t.string :gravity
      t.string :terrain
      t.string :surface_water
      t.string :population
      t.string :residents, array: true, default: []
      t.string :films, array: true, default: []
      t.string :created
      t.string :edited
      t.string :url

      t.timestamps
    end
    add_index :planets, :swapi_id, unique: true
  end
end

class CreateCubeTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :cube_times do |t|
      t.float :cube_time
      t.string :cube_type
      t.integer :cuber_id

      t.timestamps
    end
  end
end

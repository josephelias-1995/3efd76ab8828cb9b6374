class CreateRobots < ActiveRecord::Migration[6.0]
  def change
    create_table :robots do |t|
      t.string :table_cordinate
      t.boolean :is_placed

      t.timestamps
    end
  end
end

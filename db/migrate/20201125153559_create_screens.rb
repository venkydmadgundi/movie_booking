class CreateScreens < ActiveRecord::Migration[6.0]
  def change
    create_table :screens do |t|
      t.string :name
      t.integer :seats

      t.timestamps
    end
  end
end

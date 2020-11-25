class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :screen, null: false, foreign_key: true
      t.references :time_slot, null: false, foreign_key: true
      t.date :show_date
      t.integer :available_seats
      t.float :seat_price

      t.timestamps
    end
  end
end

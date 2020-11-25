class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true
      t.integer :seats
      t.decimal :total_price, precision: 8, scale: 2
      t.string :status

      t.timestamps
    end
  end
end

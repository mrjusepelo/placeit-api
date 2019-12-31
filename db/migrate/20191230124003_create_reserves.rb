class CreateReserves < ActiveRecord::Migration[5.2]
  def change
    create_table :reserves do |t|
      t.references :movie, foreign_key: true
      t.string :name
      t.string :number_document
      t.string :email
      t.string :cellphone
      t.integer :seat
      t.date :reserve_date

      t.timestamps
    end
  end
end

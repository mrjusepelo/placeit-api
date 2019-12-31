class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.string :url_image
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end

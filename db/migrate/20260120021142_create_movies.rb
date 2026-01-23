class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :movie_url
      t.string :poster
      t.string :overview
      t.string :actors
      t.integer :rating
      t.integer :user_rating
      t.string :release_date
      t.string :genre
      t.string :run_time

      t.timestamps
    end
  end
end

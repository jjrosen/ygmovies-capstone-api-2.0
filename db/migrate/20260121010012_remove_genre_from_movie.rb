class RemoveGenreFromMovie < ActiveRecord::Migration[8.1]
  def change
    remove_column :movies, :genre, :string
  end
end

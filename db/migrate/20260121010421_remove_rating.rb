class RemoveRating < ActiveRecord::Migration[8.1]
  def change
    remove_column ratings
  end
end

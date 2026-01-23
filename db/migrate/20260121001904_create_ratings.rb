class CreateRatings < ActiveRecord::Migration[8.1]
  def change
    create_table :ratings do |t|
      t.integer :rating

      t.timestamps
    end
  end
end

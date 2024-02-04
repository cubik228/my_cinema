class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :release_year
      t.text :description
      t.float :rating
      t.integer :category_id
      t.timestamps
    end

    add_foreign_key :movies, :categories, column: :category_id
  end
end
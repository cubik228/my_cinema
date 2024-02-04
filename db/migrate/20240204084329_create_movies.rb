class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title,  null: false
      t.integer :release_year,  null: false
      t.text :description,  null: false
      t.float :rating ,  null: false
      t.integer :category_id, null: false
      t.timestamps
    end

    add_foreign_key :movies, :categories, column: :category_id
  end
end
class CreateJoinTableProducersMovies < ActiveRecord::Migration[7.1]
  def change
    create_join_table :producers, :movies do |t|
      t.index [:producer_id, :movie_id]
      t.index [:movie_id, :producer_id]
      t.timestamps
    end
  end
end

class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.date :release_date
      t.integer :critics_score
      t.integer :audience_score
      t.integer :filmetric
      t.text :critics_consensus
      t.string :poster_link
      t.string :rating
      t.string :rt_link

      t.timestamps
    end
  end
end

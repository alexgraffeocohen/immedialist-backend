class AddTmdbAttributesToShows < ActiveRecord::Migration
  def change
    remove_column :shows, :creator, :string

    remove_column :shows, :episode_length, :integer
    add_column :shows, :episode_run_time, :text, array: true, default: []

    add_column :shows, :homepage, :string
    add_column :shows, :in_production, :boolean
    add_column :shows, :original_language, :string
    add_column :shows, :poster_link, :string

    rename_column :shows, :episodes_count, :number_of_episodes
    rename_column :shows, :seasons_count, :number_of_seasons
  end
end

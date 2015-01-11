# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150111232038) do

  create_table "actors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", force: :cascade do |t|
    t.string   "title"
    t.date     "release_date"
    t.string   "album_type"
    t.string   "spotify_id"
    t.integer  "spotify_popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "artist_albums", force: :cascade do |t|
    t.integer  "artist_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artist_genres", force: :cascade do |t|
    t.integer  "artist_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.integer  "spotify_popularity"
    t.string   "spotify_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_authors", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_genres", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.date     "release_date"
    t.string   "isbn"
    t.text     "cover_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_actors", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_directors", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "director_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_genres", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.date     "release_date"
    t.integer  "critics_score"
    t.integer  "audience_score"
    t.text     "critics_consensus"
    t.string   "poster_link"
    t.string   "rating"
    t.string   "rt_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trailer_link"
    t.integer  "category_id"
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.integer  "spotify_popularity"
    t.string   "spotify_url"
    t.date     "date_of_birth"
    t.date     "date_of_death"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_categories", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_actors", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_directors", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "director_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_genres", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", force: :cascade do |t|
    t.string   "title"
    t.string   "creator"
    t.integer  "episode_length"
    t.date     "first_air_date"
    t.date     "last_air_date"
    t.string   "status"
    t.integer  "seasons_count"
    t.integer  "episodes_count"
    t.integer  "tmdb_id"
    t.text     "overview"
    t.integer  "imdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.integer  "duration_ms"
    t.string   "spotify_preview_url"
    t.string   "spotify_url"
    t.integer  "spotify_popularity"
    t.string   "spotify_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "album_id"
    t.integer  "category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

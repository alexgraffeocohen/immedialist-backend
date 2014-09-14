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

ActiveRecord::Schema.define(version: 20140914041642) do

  create_table "actor_movies", force: true do |t|
    t.integer  "movie_id"
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", force: true do |t|
    t.string   "title"
    t.date     "release_date"
    t.string   "album_type"
    t.string   "spotify_id"
    t.integer  "spotify_popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artist_albums", force: true do |t|
    t.integer  "artist_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", force: true do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.integer  "spotify_popularity"
    t.string   "spotify_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "director_movies", force: true do |t|
    t.integer  "movie_id"
    t.integer  "director_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genre_movies", force: true do |t|
    t.integer  "movie_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: true do |t|
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
  end

  create_table "song_artists", force: true do |t|
    t.integer  "song_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: true do |t|
    t.string   "title"
    t.integer  "duration_ms"
    t.string   "spotify_preview_url"
    t.string   "spotify_url"
    t.integer  "spotify_popularity"
    t.string   "spotify_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

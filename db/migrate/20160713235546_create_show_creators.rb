class CreateShowCreators < ActiveRecord::Migration
  def change
    create_table :show_creators do |t|
      t.references :show, null: false, index: true
      t.references :creator, null: false, index: true

      t.timestamps null: false
    end
  end
end

class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :title,       :null => false
      t.text     :description
      t.string   :image
      t.datetime :commit_date
      t.integer  :creator_id,  :null => false

      t.timestamps
    end
  end
end

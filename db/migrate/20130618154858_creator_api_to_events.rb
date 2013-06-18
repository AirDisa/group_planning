class CreatorApiToEvents < ActiveRecord::Migration
  def change
    add_column :events, :creator_api, :string
  end
end

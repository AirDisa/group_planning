class AddSettledToEvent < ActiveRecord::Migration
  def change
    add_column :events, :settled, :boolean
  end
end

class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :url, :string, :nil => false
    add_index :events, :url, :unique => true
  end
end

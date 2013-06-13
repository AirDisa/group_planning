class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :url, :string, :nil => false
    add_index :users, :url, :unique => true

  end
end

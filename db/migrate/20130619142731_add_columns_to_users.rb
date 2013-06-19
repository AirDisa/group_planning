class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :text
    add_column :users, :web, :string
  end
end

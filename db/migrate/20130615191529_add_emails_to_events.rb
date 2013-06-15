class AddEmailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :emails, :text
  end
end

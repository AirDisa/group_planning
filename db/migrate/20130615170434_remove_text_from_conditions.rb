class RemoveTextFromConditions < ActiveRecord::Migration
  def up
    remove_column :conditions, :text
  end

  def down
    add_column :conditions, :text, :string
  end
end

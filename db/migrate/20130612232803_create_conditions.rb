class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :text,   :null => false
      t.string :method, :null => false
      t.string :value,  :null => false

      t.timestamps
    end
  end
end

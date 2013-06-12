class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.references :user,   :null => false
      t.references :event,  :null => false
      t.string     :status, :null => false

      t.timestamps
    end
    add_index :invitees, :user_id
    add_index :invitees, :event_id
  end
end

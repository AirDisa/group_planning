class CreateInviteeConditions < ActiveRecord::Migration
  def change
    create_table :invitee_conditions do |t|
      t.references :condition, :null => false
      t.references :invitee,   :null => false

      t.timestamps
    end
    add_index :invitee_conditions, :condition_id
    add_index :invitee_conditions, :invitee_id
  end
end

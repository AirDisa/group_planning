class SetDefaultForInvitees < ActiveRecord::Migration
  def up
    change_column :invitees, :status, :string, :default => "Pending"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end

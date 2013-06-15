class AddRespondedToInvitees < ActiveRecord::Migration
  def change
    add_column :invitees, :responded, :boolean, :default => false
  end
end

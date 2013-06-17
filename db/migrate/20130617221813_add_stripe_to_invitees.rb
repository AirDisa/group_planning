class AddStripeToInvitees < ActiveRecord::Migration
  def change
    add_column :invitees, :stripe_id, :string
  end
end

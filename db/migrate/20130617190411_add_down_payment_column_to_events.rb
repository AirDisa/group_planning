class AddDownPaymentColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :down_payment, :integer
  end
end

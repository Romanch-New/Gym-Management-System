class AddSubscriptionToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :subscription, :boolean
  end
end

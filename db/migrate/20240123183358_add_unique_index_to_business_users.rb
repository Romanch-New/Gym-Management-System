class AddUniqueIndexToBusinessUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :business_users, %i[business_id user_id], unique: true
  end
end

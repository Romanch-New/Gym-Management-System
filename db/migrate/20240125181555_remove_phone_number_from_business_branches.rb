class RemovePhoneNumberFromBusinessBranches < ActiveRecord::Migration[7.1]
  def change
    remove_column :business_branches, :phone_number, :string, limit: 15
  end
end

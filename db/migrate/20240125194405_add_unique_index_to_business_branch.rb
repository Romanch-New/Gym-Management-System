class AddUniqueIndexToBusinessBranch < ActiveRecord::Migration[7.1]
  def change
    add_index :business_branches, :name, unique: true
  end
end

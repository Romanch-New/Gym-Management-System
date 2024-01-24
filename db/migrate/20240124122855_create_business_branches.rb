class CreateBusinessBranches < ActiveRecord::Migration[7.1]
  def change
    create_table :business_branches do |t|
      t.string :name
      t.string :phone_number, limit: 15
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end

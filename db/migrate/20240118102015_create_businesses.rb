class CreateBusinesses < ActiveRecord::Migration[7.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.integer :business_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

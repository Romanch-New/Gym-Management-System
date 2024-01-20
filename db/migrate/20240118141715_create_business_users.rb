# frozen_string_literal: true

class CreateBusinessUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :business_users do |t|
      t.references :business, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end

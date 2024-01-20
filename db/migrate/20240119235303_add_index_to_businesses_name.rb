# frozen_string_literal: true

# AddIndexToBusinessesName adds an index to the name column of the businesses
class AddIndexToBusinessesName < ActiveRecord::Migration[7.1]
  def change
    add_index :businesses, :name, unique: true
  end
end

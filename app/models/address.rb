# frozen_string_literal: true
# app/models/address.rb
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :address_type, :line1, :city, :postal_code, :country, presence: true

  enum address_type: { billing: 0, shipping: 1 }

end

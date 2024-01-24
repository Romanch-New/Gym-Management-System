# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  address_type     :integer
#  addressable_type :string           not null
#  city             :string
#  country          :string
#  line1            :string
#  line2            :string
#  postal_code      :string
#  state            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint           not null
#
# Indexes
#
#  index_addresses_on_addressable  (addressable_type,addressable_id)
#
require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  fixtures :addresses, :businesses, :users
  test 'should not save address without addressable' do
    address = Address.new
    assert_not address.valid?, 'Address is valid without an addressable'
    assert_includes address.errors[:addressable], 'must exist'
  end
  test 'should save address with addressable' do
    address = addresses(:one)
    address.addressable = users(:one)
    assert address.valid?, 'Address is valid with addressable'
    assert_equal address.addressable, users(:one)
  end
  test 'should not save address without address_type' do
    address = Address.new
    assert_not address.valid?, 'Address is valid without an address_type'
    assert_includes address.errors[:address_type], "can't be blank"
  end
  test 'should save address with address_type' do
    address = addresses(:one)
    address.address_type = 'billing'
    assert address.valid?, 'Address is valid with address_type'
    assert_equal address.address_type, 'billing'
  end
  test 'should not save address with invalid address_type' do
    address = addresses(:one)
    assert_raises ArgumentError do
      address.address_type = 'invalid'
    end
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id            :bigint           not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :bigint
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource                                (resource_type,resource_id)
#
require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end
  test 'role with admin name can be created' do
    role = Role.new(name: 'admin')
    assert role.valid?
  end
  test 'role with new_user name can be created' do
    role = Role.new(name: 'new_user')
    assert role.valid?
  end
  test 'role with coach name can be created' do
    role = Role.new(name: 'coach')
    assert role.valid?
  end
  test 'role with nutritionist name can be created' do
    role = Role.new(name: 'nutritionist')
    assert role.valid?
  end
  test 'role with member name can be created' do
    role = Role.new(name: 'member')
    assert role.valid?
  end
  test 'role with staff name can be created' do
    role = Role.new(name: 'staff')
    assert role.valid?
  end
  test 'role with guest name can be created' do
    role = Role.new(name: 'guest')
    assert role.valid?
  end

  test 'role with non-predefined name cannot be created' do
    role = Role.new(name: 'non_predefined_role')
    assert_not role.valid?
    assert_equal ['is not a predefined role'], role.errors[:name]
  end
end

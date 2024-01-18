require "test_helper"

class RoleTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end
  test "role with admin name can be created" do
    role = Role.new(name: 'admin')
    assert role.valid?
  end
  test "role with new_user name can be created" do
    role = Role.new(name: 'new_user')
    assert role.valid?
  end
  test "role with coach name can be created" do
    role = Role.new(name: 'coach')
    assert role.valid?
  end
  test "role with nutritionist name can be created" do
    role = Role.new(name: 'nutritionist')
    assert role.valid?
  end
  test "role with member name can be created" do
    role = Role.new(name: 'member')
    assert role.valid?
  end
  test "role with staff name can be created" do
    role = Role.new(name: 'staff')
    assert role.valid?
  end
  test "role with guest name can be created" do
    role = Role.new(name: 'guest')
    assert role.valid?
  end

  test "role with non-predefined name cannot be created" do
    role = Role.new(name: 'non_predefined_role')
    assert_not role.valid?
    assert_equal ["is not a predefined role"], role.errors[:name]
  end
end

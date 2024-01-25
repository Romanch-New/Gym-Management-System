# frozen_string_literal: true

# == Schema Information
#
# Table name: business_branches
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint           not null
#
# Indexes
#
#  index_business_branches_on_business_id  (business_id)
#  index_business_branches_on_name         (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#
require 'test_helper'

class BusinessBranchTest < ActiveSupport::TestCase
  fixtures :business_branches, :businesses

  test 'should not save branch without name' do
    branch = BusinessBranch.new
    assert_not branch.valid?, 'Branch is valid without a name'
    assert_includes branch.errors[:name], "can't be blank"

    branch = business_branches.first
    assert branch.valid?, 'Branch is valid with a name'
    assert_equal branch.name, business_branches.first.name
  end

  test 'should not save branch with duplicate name' do
    branch1 = business_branches.first
    assert branch1.valid?, 'Branch is not valid with a unique name'

    branch2 = business_branches.second
    branch2.name = branch1.name

    assert_not branch2.valid?, 'Branch is valid with a duplicate name'
    assert_includes branch2.errors[:name], 'has already been taken'
  end

  test 'should not save branch without business' do
    branch = BusinessBranch.new(name: 'Test')
    assert_not branch.valid?, 'Branch is valid without a business'
    assert_includes branch.errors[:business], 'must exist'

    branch.business = businesses.first
    assert branch.valid?, 'Branch is valid with a business'
  end
end

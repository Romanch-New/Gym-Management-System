# == Schema Information
#
# Table name: business_branches
#
#  id           :bigint           not null, primary key
#  name         :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  business_id  :bigint           not null
#
# Indexes
#
#  index_business_branches_on_business_id  (business_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#
require "test_helper"

class BusinessBranchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

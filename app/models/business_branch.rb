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
class BusinessBranch < ApplicationRecord
  belongs_to :business

  validates :name, presence: true, uniqueness: true

  has_one :address, as: :addressable, dependent: :destroy
  has_one :profile, as: :profileable, dependent: :destroy
end

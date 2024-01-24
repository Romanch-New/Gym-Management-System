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
class BusinessBranch < ApplicationRecord
  belongs_to :business

  validates :name, presence: true
  validates :phone_number, presence: true,
                           length: { minimum: 10, maximum: 17 },
                           format: { with: /\A\+?\d{10,17}\z/, message: I18n.t('business_branch.phone_number_error') }

  has_one :address, as: :addressable, dependent: :destroy
end

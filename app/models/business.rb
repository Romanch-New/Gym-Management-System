# frozen_string_literal: true

# == Schema Information
#
# Table name: businesses
#
#  id            :bigint           not null, primary key
#  business_type :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_businesses_on_name     (name) UNIQUE
#  index_businesses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Business < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id', inverse_of: :created_businesses
  has_many :business_users, dependent: :destroy
  has_many :users, through: :business_users
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :business_branches, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :business_type, presence: true, inclusion: { in: %w[business personal] }

  scope :business, -> { where(business_type: 0) }
  scope :personal, -> { where(business_type: 1) }

  enum business_type: { business: 0, personal: 1 }

end

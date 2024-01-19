# frozen_string_literal: true

class BusinessUser < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  validates :business_id, presence: true
  validates :user_id, presence: true
  validates :role, presence: true
end

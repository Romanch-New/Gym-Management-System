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
class Role < ApplicationRecord
  include RoleType

  has_many :user_role, dependent: :destroy
  has_many :user, through: :user_role

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates_each :name do |record, attr, value|
    record.errors.add(attr, 'is not a predefined role') unless PREDEFINED_ROLES.include?(value)
  end

  after_initialize :set_default_role, if: :new_record?

  scopify

  private

  def set_default_role
    self.name ||= 'guest'
  end
end

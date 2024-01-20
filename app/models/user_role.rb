# frozen_string_literal: true

# UserRole is a join model that establishes the many-to-many association
# between User and Role models. Each record represents a specific role
# assigned to a specific user.
class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role
end

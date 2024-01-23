# frozen_string_literal: true

# for unique role in multiple models
module RoleType
  extend ActiveSupport::Concern

  PREDEFINED_ROLES = %w[admin new_user member staff coach nutritionist guest].freeze
end

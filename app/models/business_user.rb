# frozen_string_literal: true

# ## Schema Information
#
# Table name: `business_users`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `bigint`           | `not null, primary key`
# **`role`**         | `string`           |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
# **`business_id`**  | `bigint`           | `not null`
# **`user_id`**      | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_business_users_on_business_id`:
#     * **`business_id`**
# * `index_business_users_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`business_id => businesses.id`**
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
class BusinessUser < ApplicationRecord
  belongs_to :business
  belongs_to :user
  validates :role, presence: true
end

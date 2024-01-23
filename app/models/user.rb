# frozen_string_literal: true

# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `bigint`           | `not null, primary key`
# **`admin`**                   | `boolean`          | `default(FALSE)`
# **`email`**                   | `string`           | `default(""), not null`
# **`encrypted_password`**      | `string`           | `default(""), not null`
# **`remember_created_at`**     | `datetime`         |
# **`reset_password_sent_at`**  | `datetime`         |
# **`reset_password_token`**    | `string`           |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6, maximum: 128 }
  validates :password_confirmation, presence: true
  validates :admin, inclusion: { in: [true, false] }

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles, as: :resource
  has_many :created_businesses, class_name: 'Business', inverse_of: :creator, dependent: :destroy
  has_many :business_users, dependent: :destroy
  has_many :businesses, through: :business_users

  rolify

  scope :admin, -> { where(admin: true) }
  scope :find_by_roles, ->(roles) { joins(:roles).where(roles: { name: roles }) }
  scope :find_by_business, ->(business) { joins(:businesses).where(businesses: { name: business }) }

  after_create :assign_default_role

  def assign_default_role
    add_role(:new_user) if roles.blank?
  end

  def admin?
    admin
  end
end

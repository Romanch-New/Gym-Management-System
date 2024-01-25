# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id               :bigint           not null, primary key
#  about            :text             default("I am a member of Sweat Society App.")
#  first_name       :string
#  last_name        :string
#  phone_number     :string(15)
#  profession       :string           default("none")
#  profileable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  profileable_id   :bigint           not null
#
# Indexes
#
#  index_profiles_on_profileable  (profileable_type,profileable_id)
#
class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :profileable, polymorphic: true

  validates :first_name, :last_name, presence: true
  validates :phone_number, presence: true,
                           length: { minimum: 10, maximum: 17 },
                           format: { with: /\A\+?\d{10,17}\z/, message: I18n.t('profile.phone_number_error') }

end

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
require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  fixtures :profiles, :users

  test 'should not save profile without first name' do
    profile = Profile.new(first_name: nil)
    assert_not profile.valid?, 'Profile is valid without a first name'
    assert_includes profile.errors[:first_name], "can't be blank"
  end

  test 'should not save profile without last name' do
    profile = Profile.new(last_name: nil)
    assert_not profile.valid?, 'Profile is valid without a last name'
    assert_includes profile.errors[:last_name], "can't be blank"
  end

  test 'should not save profile without phone number' do
    profile = Profile.new(phone_number: nil)
    assert_not profile.valid?, 'Profile is valid without a phone number'
    assert_includes profile.errors[:phone_number], "can't be blank"
  end
end

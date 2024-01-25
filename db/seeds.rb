# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# # reset database and all tables to a clean state when running db:seed
# # rails db:seed:replant
require 'faker'

def create_address(addressable)
  Address.create!(
    addressable:,
    address_type: 'shipping',
    line1: Faker::Address.street_address,
    line2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    postal_code: Faker::Address.zip
  )
end

def create_profile(profileable)
  Profile.create!(
    profileable:,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone_in_e164
  )
end
# Create a default admin user
2.times do
  User.find_or_create_by!(email: Faker::Internet.email, admin: true) do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
end

# Create a default new_user user
10.times do
  User.find_or_create_by!(email: Faker::Internet.email, admin: false) do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
end

User.find_each do |user|
  create_address(user)
  create_profile(user)
end

User.admin.each do |admin|
  Business.find_or_create_by!(name: Faker::Company.name, business_type: 0) do |business|
    business.user_id = admin.id
  end
end

Role::PREDEFINED_ROLES.each do |role|
  Role.find_or_create_by!(name: role, resource_type: 'Business')
end

# create a default business user
Business.find_each do |business|
  10.times do
    role = Role.all.sample
    p = 'Faker::Internet.password'
    user = User.create!(email: Faker::Internet.email,
                        admin: false,
                        password: p,
                        password_confirmation: p)
    BusinessUser.create!(business_id: business.id, user_id: user.id, role: role.name)
    create_address(user)
    create_profile(user)
  end

  create_address(business)
  create_profile(business)
  BusinessBranch.create!(business_id: business.id,
                         name: Faker::Company.name)
  business.business_branches.each do |branch|
    create_address(branch)
    create_profile(branch)
  end
end

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
require "faker"

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

User.admin.each do |admin|
  Business.find_or_create_by!(name: Faker::Company.name, business_type: 0) do |business|
    business.user_id = admin.id
  end
end
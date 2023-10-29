# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Define the number of employee records you want to create
num_employees = 10  # Change this number as needed

# Create employee records
num_employees.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  nick_name = Faker::Internet.username(specifier: "#{first_name} #{last_name}", separators: %w(_ . -))
  email = Faker::Internet.email
  phone = Faker::PhoneNumber.phone_number

  Employee.create!(
    first_name: first_name,
    last_name: last_name,
    nick_name: nick_name,
    email: email,
    phone: phone
  )
end

puts "Seed data created successfully!"
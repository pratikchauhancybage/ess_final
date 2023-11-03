# spec/models/employee_spec.rb

require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:valid_attributes) do
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      phone: '123-456-7890'
    }
  end

  it 'is valid with valid attributes' do
    employee = Employee.new(valid_attributes)
    expect(employee).to be_valid
  end

  it 'has a valid email format' do
    employee = Employee.new(valid_attributes.merge(email: 'invalid-email'))
    expect(employee).to_not be_valid
  end

  it 'ensures email uniqueness' do
    existing_employee = Employee.create(valid_attributes)
    new_employee = Employee.new(valid_attributes)
    expect(new_employee).to_not be_valid
  end

  it 'has a one-to-one association with Employment' do
    association = Employee.reflect_on_association(:employment)
    expect(association.macro).to eq :has_one
  end

  it 'converts email to lowercase before validation' do
    email = 'John@Example.com'
    employee = Employee.new(valid_attributes.merge(email: email))
    employee.valid?
    expect(employee.email).to eq email.downcase
  end
end

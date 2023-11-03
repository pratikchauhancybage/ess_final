# spec/models/employment_spec.rb

require 'rails_helper'

RSpec.describe Employment, type: :model do
  let(:valid_attributes) do
    {
      start_date: Date.today,
      end_date: Date.tomorrow,
      employee: Employee.new
    }
  end

  it 'is valid with valid attributes' do
    employment = Employment.new(valid_attributes)
    expect(employment).to be_valid
  end

  it 'belongs to an employee' do
    association = Employment.reflect_on_association(:employee)
    expect(association.macro).to eq :belongs_to
  end
end

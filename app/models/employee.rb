class Employee < ApplicationRecord
	has_one :employment
	before_validation { self.email = email.downcase }

	validates :email, uniqueness: {message: 'already exists'}
end

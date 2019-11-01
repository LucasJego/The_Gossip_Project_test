class Tag < ApplicationRecord
	has_many :taggers
	has_many :potins, through: :taggers

	validates :title,
		presence: true
end

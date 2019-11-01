class Potin < ApplicationRecord
	belongs_to :user
        has_many :taggers
        has_many :tags, through: :taggers
        has_many :comments
	has_many :likes

    validates :title,
    	presence: true,
    	length: { in: 3..14, message: "Un titre de 3 à 14 caractères est obligatoire."}
    validates :content,
    	presence: {message: "Un potin ne doit pas être vide."}
end

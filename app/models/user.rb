class User < ApplicationRecord
	belongs_to :city
	has_many :potins
	has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
	has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"
        has_many :comments
	has_many :likes
	has_secure_password

	validates :first_name,
    	presence: true
    validates :last_name,
    	presence: true
    validates :age,
	    presence: true,
	    numericality: { greater_than: 0 }
  	validates :description,
	    presence: true,
	    length: { minimum: 10 }   
  	validates :email,
	    presence: true,
	    uniqueness: true,
	    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Renseignez une adresse email valide." }

end
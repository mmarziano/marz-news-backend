class User < ApplicationRecord
    serialize :preferences_categories, Array
    has_secure_password 

    has_and_belongs_to_many :articles

    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :first_name, length: {minimum: 3}

    def full_name 
        self.first_name.capitalize + " " + self.last_name.capitalize
    end 

end

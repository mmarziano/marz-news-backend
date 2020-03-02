class Article < ApplicationRecord
    has_and_belongs_to_many :users
    
    def total_saves
        self.users.count
    end 

end

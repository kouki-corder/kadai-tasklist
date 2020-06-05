class Task < ApplicationRecord
    
    validates :status, presence: true, length: { maximum: 10}
    validates :content, presence: true
    
    belongs_to :user
end

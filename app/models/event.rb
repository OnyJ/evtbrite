class Event < ApplicationRecord
    # scope :administrator, -> { where(admin: current_user.id ) }
      
    validates :title, presence: true, length: { in: 4..140 }
    validates :description, presence: true, length: { in: 20..1000 }
    validates :price,
      presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than: 1000
      }
    validates :location, presence: true
    validates :duration, presence: true
    validate :is_multiple_of_5
    validates :start_date, presence: true
    validate :date_passed

    has_many :attendances
    has_many :users, through: :attendances

    def end_date
        start_date + duration * 60
    end

    def participale?(user)
        users.include?(user)
    end

    def is_free?
        price == 0
    end

    private
    
    def date_passed
        if start_date.present? && start_date < Date.today
          errors.add(:start_date, "can't be past")
        end
    end

    def is_multiple_of_5
        errors.add(:duration, "has to be a multiple of 5") unless duration % 5 == 0 
    end
end
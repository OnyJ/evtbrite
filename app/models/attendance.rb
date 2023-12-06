class Attendance < ApplicationRecord
    after_create_commit :welcome_event_send
 
    belongs_to :user
    belongs_to :event

    def welcome_event_send
        UserMailer.welcome_event_email(self.event, self.user).deliver_now
    end 
end

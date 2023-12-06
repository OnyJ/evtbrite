class Profile < ApplicationRecord
    belongs_to :user

    def full_name
        "#{self.first_name} #{self.last_name}"
    end

    def check_privileges!
        redirect_to root_path, notice: "You dont have enough permissions" unless current_user == Profile.find(params[:id]).user
    end
end
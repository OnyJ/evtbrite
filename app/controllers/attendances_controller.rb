class AttendancesController < ApplicationController
    def index 
        @event = Event.find(params[:id])
        @attendances = @event.users
    end
end

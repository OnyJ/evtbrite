class SubscribesController < ApplicationController
    def new
    end

    def create  
        @event = Event.find(params[:id])
    
        @amount = @event.price * 100
    
        customer = Stripe::Customer.create({
          email: params[:stripeEmail],
          source: params[:stripeToken],
        })
      
        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'Eventbite payment',
          currency: 'eur',
        })
    
        # Création d'une participation d'un user à l'évènement
        @attendance = Attendance.create(stripe_customer_id: customer.id, user: current_user, event: @event)
        
        redirect_to event_path(@event.id)
      
        rescue Stripe::CardError => e
            flash[:error] = e.message
            redirect_to @event
    end

    def free_subscribe
      @event = Event.find(params[:id])
      @attendance = Attendance.create(user: current_user, event: @event)
    
      redirect_to event_path(@event.id)
    end
end

class EventsController < ApplicationController
  def new
    @emergencies = Emergency.all
  end

  def create
    event = Event.new(
                      name: params[:name],
                      emergency_id: params[:emergency_id],
                      status: params[:status],
                      lat: params[:lat],
                      long: params[:long]
                      )
    event.save
    redirect_to "/events/#{event.id}" 
  end

  def show
    @event = Event.find(params[:id])
    @emergency = Emergency.find(@event.emergency_id)
    user_location = {lat: current_user.lat, long: current_user.long}
    @distance = @event.haversine_distance(user_location)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event.update(
                  status: params[:status],
                  lat: params[:lat],
                  long: params[:long]
                  )
    redirect_to "/events/#{event.id}"
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to '/'
  end
end

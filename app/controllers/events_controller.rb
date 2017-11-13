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
                      long: params[:long],
                      event_pic: params[:event_pic]                      
                      )
    event.save
    redirect_to "/safe_locations" 
  end

  def show
    @event = Event.find(params[:id])
    @emergency = Emergency.find(@event.emergency_id)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event.update(
                  status: params[:status],
                  lat: params[:lat],
                  long: params[:long],
                  event_pic: params[:event_pic]
                  )
    redirect_to "/safe_locations"
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to '/'
  end
end

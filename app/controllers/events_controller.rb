class EventsController < ApplicationController
  def new
    @emergency = Emergency.all
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
    @emergency = Emergency.all
    @event = Event.find(params[:id])
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
end

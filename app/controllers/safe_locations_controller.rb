class SafeLocationsController < ApplicationController
  def index
    @safe_locations = SafeLocation.all
    @emergencies = Emergency.all
    @services = ReliefService.all
    @events = Event.all
    
    if current_user
      user_location = {lat: current_user.lat, long: current_user.long}
    end

    emergency_cat = params[:emergency_cat]
    
    if emergency_cat
      emergency = Emergency.find(emergency_cat)
      @safe_locations = emergency.safe_locations
      @events = emergency.events
      @services = emergency.relief_services
    end

    @sl_markers = []
    @safe_locations.each do |sl|
      @sl_markers << [
                      sl.name,
                      sl.status,
                      sl.lat,
                      sl.long,
                      "/safe_locations/#{sl.id}",
                      sl.id
                      ]
    end


    @event_markers = []
    @events.each do |event|
      @event_markers << [
                        event.name,
                        event.status,
                        event.lat,
                        event.long,
                        "/events/#{event.id}",
                        event.id
                        ]
    end
  end
  
  def new
    
  end
  
  def create
    safe_location = SafeLocation.new(
                                    name: params[:name],
                                    lat: params[:lat],
                                    long: params[:long],
                                    status: params[:status]
                                    )
    safe_location.save
    redirect_to "/safe_locations/"
  end

  def show
    @safe_location = SafeLocation.find(params[:id])
    user_location = {lat: current_user.lat, long: current_user.long}
    @distance = @safe_location.haversine_distance(user_location)
  end

  def edit
    @safe_location = SafeLocation.find(params[:id])
  end

  def update
    safe_location = SafeLocation.find(params[:id])
    safe_location.update(
                        name: params[:name],
                        lat: params[:lat],
                        long: params[:long],
                        status: params[:status]
                        )
    redirect_to "/safe_locations/"
  end

  def destroy
    safe_location = SafeLocation.find(params[:id])
    safe_location.destroy
    redirect_to '/'
  end
end

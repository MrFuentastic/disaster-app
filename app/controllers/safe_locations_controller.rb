class SafeLocationsController < ApplicationController
  def index
    @safe_locations = SafeLocation.all
    @emergencies = Emergency.all
    @services = ReliefService.all
    @events = Event.all

    user_location = {lat: current_user.lat, long: current_user.long}

    distance = params[:dist]
    emergency_cat = params[:emergency_cat]
    dist = params[:dist]
    
    if emergency_cat
      emergency = Emergency.find(emergency_cat)
      @safe_locations = emergency.safe_locations
    end

    if distance
      # move to model method if you can
      @safe_locations = @safe_locations.sort_by { |location| location.haversine_distance(user_location) }
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
    redirect_to "/safe_locations/#{safe_location.id}"
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
    redirect_to "/safe_locations/#{safe_location.id}"
  end

  def destroy
    safe_location = SafeLocation.find(params[:id])
    safe_location.destroy
    redirect_to '/'
  end
end

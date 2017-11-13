class SafeLocationsController < ApplicationController
  def index
    @safe_locations = SafeLocation.all
    @emergencies = Emergency.all
    @services = ReliefService.all
    @events = Event.all

    if current_user
      @user_location = [
        current_user.lat, 
        current_user.long
      ]
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
                      sl.id,
      if sl.sl_image.url
        @sl_markers << sl.sl_image.url(:medium)
      end
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
                        event.id,
                        event.emergency.name,
                        ]
      if event.event_pic.url
        @event_markers << event.event_pic.url(:medium)
      end
    end
  end
  
  def new
    
  end
  
  def create
    safe_location = SafeLocation.new(
                                    name: params[:name],
                                    lat: params[:lat],
                                    long: params[:long],
                                    status: params[:status],
                                    sl_image: params[:sl_image]                                    
                                    )
    safe_location.save
    redirect_to "/safe_locations/"
  end

  def show
    @safe_location = SafeLocation.find(params[:id])
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
                        status: params[:status],
                        sl_image: params[:sl_image]
                        )
    redirect_to "/safe_locations/"
  end

  def destroy
    safe_location = SafeLocation.find(params[:id])
    safe_location.destroy
    redirect_to '/'
  end
end

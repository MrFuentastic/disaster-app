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
      sl_array = [
                      sl.name,
                      sl.status,
                      sl.lat,
                      sl.long,
                      "/safe_locations/#{sl.id}",
                      sl.id,
                      "sl_image"
                    ]
      if sl.sl_image.url
        sl_array << sl.sl_image.url(:medium)
      end
      @sl_markers << sl_array
    end

    @event_markers = []
    @events.each do |event|
      event_array = [
                        event.name,
                        event.status,
                        event.lat,
                        event.long,
                        "/events/#{event.id}",
                        event.id,
                        event.emergency.name,
                        "event_pic"
                        ]
      if event.event_pic.url
        event_array << event.event_pic.url(:medium)
      end
      @event_markers << event_array
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
    safe_location.assign_attributes(
                        name: params[:name],
                        lat: params[:lat],
                        long: params[:long],
                        status: params[:status]
                        )
    safe_location.sl_image = params[:sl_image] unless params[:sl_image] == "" || params[:sl_image] == nil
    safe_location.save
    redirect_to "/safe_locations/"
  end

  def destroy
    safe_location = SafeLocation.find(params[:id])
    safe_location.destroy
    redirect_to '/'
  end
end

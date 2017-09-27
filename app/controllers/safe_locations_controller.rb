class SafeLocationsController < ApplicationController
  def index
    @safe_locations = SafeLocation.all
    @emergencies = Emergency.all
    @services = ReliefService.all
    
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

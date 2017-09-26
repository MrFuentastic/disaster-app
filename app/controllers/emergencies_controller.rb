class EmergenciesController < ApplicationController

  def index
    @emergencies = Emergency.all
  end

  def new

  end

  def create
    emergency = Emergency.new(
                              name: params[:name]
                              )
    emergency.save
    redirect_to "/emergencies/#{emergency.id}" 
  end

  def show
    @emergency = Emergency.find(params[:id])
  end

  def edit
    @emergency = Emergency.find(params[:id])
  end

  def update
    emergency = Emergency.find(params[:id])
    emergency.update(
                    name: params[:name]
                    )
    redirect_to "/emergencies/#{emergency.id}"
  end
end

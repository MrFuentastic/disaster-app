class ReliefServicesController < ApplicationController
  def new
  end
  
  def create
    service = ReliefService.new(
                                name: params[:name],
                                phone: params[:phone]
    )
    service.save

    redirect_to "/services/#{service.id}"
  end

  def show
    @service = ReliefService.find(params[:id])
  end

  def edit
    @service = ReliefService.find(params[:id])
  end

  def update
    service = ReliefService.find(params[:id])
    service.update(
                    name: params[:name],
                    phone: params[:phone]
    )

    redirect_to "/services/#{service.id}"
  end

  def destroy
    relief_service = ReliefService.find(params[:id])
    relief__service.destroy
    redirect_to '/'
  end
end

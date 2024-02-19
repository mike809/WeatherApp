class LocationsController < ApplicationController

  def create
    @location = Current.user.locations.new(location_params)
    if @location.save
      flash.now[:notice] = "Location pinned successfully."
      # redirect_to root_path
      render turbo_stream: [
        turbo_stream.replace(:flash_messages, partial: "shared/flash_messages")
      ]
    else
      render turbo_stream: [
        turbo_stream.replace(:flash_messages, "shared/flashes")
      ]
    end
  end

  def index
    @locations = Current.user.locations
  end

  private

  def location_params
    params.require(:location).permit(:address)
  end
end

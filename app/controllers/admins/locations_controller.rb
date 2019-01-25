class Admins::LocationsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      flash[:notice] = @location.location_name + "を編集しました。"
      redirect_to admins_locations_path
    else
      flash[:alert] = "編集できませんでした。"
      render "edit"
    end
  end

  def destroy
    location = Location.find(params[:id])
    location.destroy
    redirect_to admins_locations_path
    flash[:alert] = location.location_name + "を削除しました。"
  end

  private

  def location_params
    params.require(:location).permit(
      :location_name,
      :location_image,
      :station,
      :location_url,
      :location_memo,
      :address,
      :latitude,
      :longitude,
      :public_status,
      :user_id
    )
  end

end

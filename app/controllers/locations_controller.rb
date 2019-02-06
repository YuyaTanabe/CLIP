class LocationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.user_id = current_user.id
    if @location.save
      flash[:notice] = "クリップ完了"
      redirect_to location_path(@location.id)
    else
      render "new"
    end
  end

  def show
    @location = Location.find(params[:id])
    @l_user = User.find_by(id: @location.user_id)
    if current_user.is_friend?(@l_user)
    elsif current_user.id == @l_user.id
    else
      flash[:alert] = "そのページへは行けません。"
      redirect_to user_path(current_user.id)
    end
  end

  def edit
    @location = Location.find(params[:id])
    if current_user.id == @location.user_id
    else
      flash[:alert] = "そのページへは行けません。"
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      if @location.address.empty?
        @location.update(latitude: nil, longitude: nil)
        flash[:notice] = @location.location_name + "を編集しました。"
        redirect_to location_path(@location.id)
      else
        flash[:notice] = @location.location_name + "を編集しました。"
        redirect_to location_path(@location.id)
      end
    else
      flash[:alert] = "編集できませんでした。"
      render "edit"
    end
  end

  def destroy
    location = Location.find(params[:id])
    location.really_destroy!
    redirect_to user_path(current_user)
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

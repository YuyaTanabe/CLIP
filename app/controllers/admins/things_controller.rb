class Admins::ThingsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @things = Thing.all
  end

  def show
    @thing = Thing.with_deleted.find(params[:id])
  end

  def edit
    @thing = Thing.with_deleted.find(params[:id])
  end

  def update
    @thing = Thing.with_deleted.find(params[:id])
    if @thing.update(thing_params)
      flash[:notice] = @thing.thing_name + "を編集しました。"
      redirect_to admins_thing_path(@thing.id)
    else
      flash[:alert] = "編集できませんでした。"
      render "edit"
    end
  end

  def destroy
    thing = Thing.with_deleted.find(params[:id])
    thing.really_destroy!
    flash[:alert] = thing.thing_name + "を削除しました。"
    redirect_to admins_things_path
  end

  def thing_params
    params.require(:thing).permit(
      :thing_name,
      :thing_image,
      :thing_url,
      :thing_memo,
      :public_status,
      :user_id
    )
  end

end

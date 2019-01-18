class ThingsController < ApplicationController
  def index
    @things = Thing.all
  end

  def new
    @thing = Thing.new
  end

  def create
    thing = Thing.new(thing_params)
    thing.user_id = current_user.id
    if thing.save
      flash[:notice] = "クリップ完了"
      redirect_to thing_path(thing.id)
    else
      @thing = Thing.new
      render "new"
    end
  end

  def show
    @thing = Thing.find(params[:id])
  end

  def edit
    @thing = Thing.find(params[:id])
  end

  def update
    thing = Thing.find(params[:id])
    if thing.update(thing_params)
      flash[:notice] = thing.thing_name + "を編集しました"
      redirect_to thing_path(thing.id)
    else
      @thing = Thing.find(params[:id])
      flash[:notice] = @thing.thing_name + "を編集できませんでした"
      render "edit"
    end
  end

  def destroy
    thing = Thing.find(params[:id])
    thing.destroy
    flash[:alert] = thing.thing_name + "を削除しました"
    redirect_to user_path(current_user)
  end

  private

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

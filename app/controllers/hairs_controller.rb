class HairsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_hair, only: [:edit, :update, :destroy, :show]

  def index
    @hairs = Hair.all
  end

  def show
  end

  def new
    @hair = Hair.new
  end

  def create
    @hair = Hair.new(hair_params)
    if @hair.save
      redirect_to hairs_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @hair.update(hair_params)
      redirect_to hairs_path, notice: "Hair updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @hair.destroy
    redirect_to hairs_path, notice: "Hair deleted"
  end

  private

  def set_hair
    @hair = Hair.find(params[:id])
  end

  def hair_params
    params.require(:hair).permit(:photo, :price, :length, :texture, :origin, :quantity)
  end

end

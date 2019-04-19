class ShippingsController < ApplicationController
  before_action :load_shipping, only: %i|show edit update destroy|

  def index
    @shippings = Shipping.all
  end

  def show; end

  def new
    @shipping = Shipping.new
  end

  def edit; end

  def create
    @shipping = Shipping.new shipping_params
    @shipping.current_step = params[:current_step]

    if params[:next_step]
      @shipping.move_next_step if @shipping.valid?

      render :new
    elsif params[:pre_step]
      @shipping.move_pre_step
      
      render :new
    elsif params[:commit]
      if @shipping.save
        flash[:success] = "Shipping is created"
        redirect_to @shipping
      else
        flash.now[:danger] = "Shipping isn't created"
        render :new
      end
    end
  end

  def update
    if @shipping.update_attributes shipping_params
      flash[:success] = "Shipping is updated."
      redirect_to @shipping
    else
      flash.now[:danger] = "Shipping isn't updated."
      render :edit
    end
  end

  def destroy
    if @shipping.destroy
      flash[:success] = "Shipping is deleted."
    else
      flash[:danger] = "Shipping isn't deleted."
    end
    redirect_to root_url
  end

  private
  def load_shipping
    @shipping = Shipping.find_by id: params[:id]
    return if @shipping

    flash[:warning] = "Shipping isn't found"
    redirect_to root_url
  end

  def shipping_params
    params.require(:shipping).permit :receiver_name, :receiver_phone, :shipping_address, :shipping_day
  end
end

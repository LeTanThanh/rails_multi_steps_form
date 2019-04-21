class ShippingsController < ApplicationController
  before_action :load_shipping, only: %i|show edit update destroy|

  def index
    @shippings = Shipping.all
  end

  def show; end

  def new
    @shipping = Shipping.new
  end

  def create
    @shipping = Shipping.new shipping_params

    if @shipping.save
      flash[:success] = "Shipping is created."
      redirect_to @shipping
    else
      flash.now[:danger] = "Shipping isn't created."
      render :new
    end
  end

  def edit; end

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

  def validate_step
    shipping = Shipping.new shipping_params
    shipping.valid?

    error_attrs = shipping_params_keys.select do |attr|
      shipping.errors[attr].any?
    end
    error_messages = error_attrs.map do |attr|
      Shipping.human_attribute_name(attr) + " " + shipping.errors[attr].first
    end

    respond_to do |format|
      format.js do
        render json: {
          valid: error_messages.empty?,
          error_messages: render_to_string(
            partial: "shared/error_messages",
            locals: { error_messages: error_messages }
          ),
          confirmation: render_to_string(
            partial: "shippings/form_steps/confirmation_step",
            locals: { shipping: shipping }
          ) 
        }
      end
    end
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

  def shipping_params_keys
    case params[:step_index]
    when "0"
      [:receiver_name, :receiver_phone]
    when "1"
      [:shipping_address, :shipping_day]
    end
  end
end

class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_order, only: [:show]
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :product_id, :total)
    end
end

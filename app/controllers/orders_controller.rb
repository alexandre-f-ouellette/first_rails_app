class OrdersController < ApplicationController
  protect_from_forgery
  protect_from_forgery unless: -> { request.format.json? }
  respond_to :json, :html

  def index
    @orders = Order.all.to_json(:include => [{:product => {:only => :name}}, {:user => {:only => :email}}])
    respond_with @orders
  end

  def show
    @order = Order.find(params[:id]).to_json(:include => [{:product => {:only => :name}}, {:user => {:only => :email}}])
    respond_with @order
  end

  def new
  end

  def create
    @order = Order.create(order_params)
    respond_with @order
  end

  def destroy
    respond_with Order.destroy(params[:id])
  end

  protected
    def json_request?
      request.format.json?
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:product_id, :user_id, :total)
    end
end

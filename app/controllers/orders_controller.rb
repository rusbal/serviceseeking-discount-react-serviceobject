class OrdersController < ApiController
  def create
    # Note: Using perform_now here for testing purposes.
    order = OrderDiscountJob.perform_now(order_params[:items])

    render json: {
      message: 'Job was initiated',
      discount: order.discount, # This is for testing purposes only.
    }, status: :created
  rescue => err
    render json: {
      message: err.message,
    }, status: :unprocessable_entity
  end

  private

  def order_params
    params.permit(
      { :items => [ :sku, :price, :quantity ] }
    )
  end
end

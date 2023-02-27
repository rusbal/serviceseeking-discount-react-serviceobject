class OrdersController < ApiController
  def create
    OrderDiscountJob.perform_now(order_params[:items])
    render json: {
      message: 'Job was initiated',
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

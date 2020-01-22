class FetchApiController < ApplicationController

  def fetch_pricing_data
    data = Operations::GetPricing.new(params).execute
    render json: {data: data}
  end
end

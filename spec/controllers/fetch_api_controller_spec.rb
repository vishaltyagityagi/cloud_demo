require 'rails_helper'

RSpec.describe FetchApiController do
  describe "GET fetch_pricing_data" do
    it "assigns @teams" do
      team = [
          {"description" => "$6.0E-7  per Request for Lambda-Edge-Request in EU (Paris)",
           "beginRange" => "0",
           "endRange" => "Inf",
           "unit" => "Request",
           "pricePerUnit" => "0.0000006000",
           "effectiveDate" => "2019-12-01T00:00:00Z"}]
      get :fetch_pricing_data
      data = JSON.parse(response.body)
      expect(data["data"][0]).to eq(team[0])
    end

  end
end
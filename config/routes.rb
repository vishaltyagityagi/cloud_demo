Rails.application.routes.draw do
  get '/fetch_pricing_data/', to: 'fetch_api#fetch_pricing_data'
end

class FetchApiDataWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Operations::StoreApiResponse.new.execute
  end
end
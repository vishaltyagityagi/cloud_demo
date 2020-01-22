require './config/boot'
require './config/environment'
require 'clockwork'
require 'active_support/time'
Dir[File.join('.', "app/workers/*.rb")].each { |f| require f }


Clockwork.every(1.day, 'Create_api_data', at: '23:00') do
  FetchApiDataWorker::perform_async
end

# ### for every 2 minuts
# Clockwork.every(1.minutes, 'Create_api_data', skip_first_run: true) do
#   FetchApiDataWorker::perform_async
# end
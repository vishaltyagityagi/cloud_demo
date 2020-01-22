ActiveModelSerializers.config.adapter = :json_api
ActiveModelSerializers.config.automatic_lookup = false
ActiveModelSerializers.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new('/dev/null'))

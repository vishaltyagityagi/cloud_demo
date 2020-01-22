module Operations
  class GetPricing
    def initialize(params)
      @sr = Service.last
      @description = params[:description].to_s
      @begin_range = params[:beginRange].to_s
      @end_range = params[:endRange].to_s
      @unit = params[:unit].to_s
      @usd = params[:usd].to_s || params[:pricePerUnit].to_s
      @effective_date = params[:date].to_s || params[:effectiveDate].to_s
      @match = {}
    end

    def execute
      description_filter
      begin_range_filter
      end_range_filter
      unit_filter
      price_per_unit_filter
      effective_date_filter
      term = @sr.term_details.where(@match).to_a ### mongo match query
      serialize_data(term)
    end

    private

    def description_filter
      unless @description.empty?
        @match.merge!(:'price_dimension.description' => @description)
      end

    end

    def begin_range_filter
      unless @begin_range.empty?
        @match.merge!("price_dimension.begin_range": {"$gte": @begin_range})
      end
    end

    def end_range_filter
      unless @end_range.empty?
        @match.merge!("price_dimension.end_range": {"$lte": @end_range})
      end
    end

    def unit_filter
      unless @unit.empty?
        @match.merge!(:'price_dimension.unit' => @unit)
      end
    end

    def price_per_unit_filter
      unless @usd.empty?
        @match.merge!(:'price_dimension.price_per_unit.usd' => @usd)
      end
    end

    def effective_date_filter
      unless @effective_date.empty?
        @match.merge!(:'effective_date' => @effective_date)
      end
    end

    def serialize_data(term)
      mapper = []
      term.each do |data|
        mapper << create_serialized_hash(data)
      end
      mapper
    end

    def create_serialized_hash(data)
      {
          "description": data["price_dimension"]["description"],
          "beginRange": data["price_dimension"]["begin_range"],
          "endRange": data["price_dimension"]["end_range"],
          "unit": data["price_dimension"]["unit"],
          "pricePerUnit": data["price_dimension"]["price_per_unit"]['usd'],
          "effectiveDate": data["effective_date"]
      }
    end

  end
end

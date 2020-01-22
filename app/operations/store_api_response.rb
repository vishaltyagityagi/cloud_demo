module Operations
  class StoreApiResponse < Operations::ServiceApiCall

    def initialize
      super()
      @service = Service.create(service_mapper)
      @product_mapper = product_mapper
      @term_mapper = term_mapper
    end


    def execute
      Product::Details.collection.insert_many(@product_mapper)
      Term::Details.collection.insert_many(@term_mapper)
    end

    private

    def service_mapper
      {
          format_version: @response["formatVersion"],
          disclaimer: @response["disclaimer"],
          offer_code: @response["offerCode"],
          version: @response["version"],
          publication_date: @response["publicationDate"]
      }
    end

    def product_mapper
      @bulk_operation = []
      @response["products"].values.each(&method(:product_obj))
      @bulk_operation
    end

    def product_obj(product)
      @bulk_operation << {sku: product["sku"],
                          product_family: product["productFamily"],
                          service_id: @service.id, ### to be change
                          product_attributes: {service_code: product["attributes"]["servicecode"],
                                               location: product["attributes"]["location"],
                                               location_type: product["attributes"]["locationType"],
                                               group: product["attributes"]["group"],
                                               group_description: product["attributes"]["groupDescription"],
                                               usage_type: product["attributes"]["usagetype"],
                                               operation: product["attributes"]["operation"],
                                               service_name: product["attributes"]["servicename"]}
      }
    end

    def term_mapper
      @bulk_operation = []
      @response["terms"]["OnDemand"].values.each do |term|
        term.values.each(&method(:term_obj))
      end
      @bulk_operation
    end

    def term_obj(data)
      @bulk_operation << {
          service_id: @service.id,
          type: @response["terms"].keys[0],
          offer_term_code: data["offerTermCode"],
          sku: data["sku"],
          effective_date: data["effectiveDate"],
          term_attributes: {},
          price_dimension: {
              rate_code: data["priceDimensions"].values[0]["rateCode"],
              description: data["priceDimensions"].values[0]["description"],
              begin_range: data["priceDimensions"].values[0]["beginRange"],
              end_range: data["priceDimensions"].values[0]["endRange"],
              unit: data["priceDimensions"].values[0]["unit"],
              price_per_unit: {usd: data["priceDimensions"].values[0]["pricePerUnit"]["USD"]},
              applies_to: []
          }
      }
    end

  end
end


module Product
  class ProductAttributes
    include Mongoid::Document

    field :service_code
    field :location
    field :location_type
    field :group
    field :group_description
    field :usage_type
    field :operation
    field :service_name

    embedded_in :detail, inverse_of: :product_attributes

  end

end


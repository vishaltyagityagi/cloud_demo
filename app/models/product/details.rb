module Product
  class Details
    include Mongoid::Document
    field :product_id
    field :product_family
    field :sku

    embeds_one :product_attributes, class_name: "Product::ProductAttributes"
    belongs_to :service, inverse_of: :product_details
  end

end


module Term
  class Details
    include Mongoid::Document
    field :service_id
    field :type
    field :offer_term_code
    field :sku
    field :effective_date
    field :term_attributes, type: Hash

    embeds_one :price_dimension, class_name: "Term::PriceDimension"
    belongs_to :service, inverse_of: :term_details

  end

end





module Term
  class PriceDimension
    include Mongoid::Document
    field :rate_code
    field :description
    field :begin_range
    field :end_range
    field :unit
    field :price_per_unit, type: Hash
    field :applies_to, type: Array

    embedded_in :detail, inverse_of: :price_dimension

  end
end
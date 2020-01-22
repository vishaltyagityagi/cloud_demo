class Service
  extend Enumerize
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  validates_presence_of :format_version
  field :format_version
  field :disclaimer
  field :offer_code
  field :version
  field :publication_date

  has_many :product_details, class_name: "Product::Details"
  has_many :term_details, class_name: "Term::Details"

end
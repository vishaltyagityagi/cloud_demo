require 'rails_helper'

describe Service do
  it "have created a relationship with Category" do
    # service = Service.create({"disclaimer" =>
    #                               "This pricing list is for informational purposes only. All prices are subject to the additional terms included in the pricing pages on http://aws.amazon.com. All Free Tier prices are also subject to the terms included at https://aws.amazon.com/free/",
    #                           "format_version" => "v1.0",
    #                           "offer_code" => "AmazonCloudFront",
    #                           "publication_date" => "2019-12-19T23:07:50Z",
    #                           "version" => "20191219230750"})
    # product_details = Product::Details.create({
    #                                               "sku": "RN2BPS8XT2GYJ4UF",
    #                                               "product_family": "Serverless",
    #                                               "service_id": service.id,
    #                                               "product_attributes": {
    #                                                   "service_code": "AmazonCloudFront",
    #                                                   "location": "EU (Paris)",
    #                                                   "location_type": "AWS Region",
    #                                                   "group": "AWS-Lambda-Edge-Requests",
    #                                                   "group_description": "Invocation call for a Lambda function",
    #                                                   "usage_type": "EUW3-Lambda-Edge-Request",
    #                                                   "operation": "",
    #                                                   "service_name": "Amazon CloudFront"
    #                                               }
    #                                           })

    Service.first.product_details[0].should == Product::Details.where(service_id: Service.first.id)[0]
    Service.first.term_details[0].should == Term::Details.where(service_id: Service.first.id)[0]
  end
  it "is valid with valid attributes" do
    expect(Service.new(format_version: "Test")).to be_valid
  end

  it "is not valid without a format_version" do
    service = Service.new(format_version: nil)
    expect(service).to_not be_valid
  end
end
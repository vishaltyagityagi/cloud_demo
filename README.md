# README

* Dependencies
* Developed in Rails 5.1.5
* Using Mongoid ORM
* Used MongoDB as a database
* Used shoulda-matchers for Rspec match
* Used Figaro for application.yml to store the ENV variables
* Used clockwork for scheduling the job (like crontab), clockwork is lightweight. (We can run clock by using (clockwork clock.rb))
* Used redis as a caching database
* Used Sidekiq for backgroud jobs

# For Data Creation by rails console
* Operations::StoreApiResponse.new.execute
# To run the Cron job , it will call the worker at midnight 23:00pm
* clockwork clock.rb

# Direct call of worker with sidkiq

* FetchApiDataWorker::perform_async

#API
*  http://localhost:4000/fetch_pricing_data
- Sample Response

[

    {
        "description": "$6.0E-7  per Request for Lambda-Edge-Request in EU (Paris)",
        "beginRange": "0",
        "endRange": "Inf",
        "unit": "Request",
        "pricePerUnit": "0.0000006000",
        "effectiveDate": "2019-12-01T00:00:00Z"
    },
    {
        "description": "$0.0100 per 10,000 HTTPS Requests",
        "beginRange": "0",
        "endRange": "Inf",
        "unit": "Requests",
        "pricePerUnit": "0.0000010000",
        "effectiveDate": "2019-12-01T00:00:00Z"
    }
    
]

# Example For  Filters Api
* Availabe filter options
description,beginRange,endRange,unit,pricePerUnit,effectiveDate,date,usd

* http://localhost:4000/fetch_pricing_data?description= $6.0E-7  per Request for Lambda-Edge-Request in EU (Paris)
* http://localhost:4000/fetch_pricing_data?unit=Request
* http://localhost:4000/fetch_pricing_data?unit=Request&pricePerUnit=0.0000006000&description=$6.0E-7  per Request for Lambda-Edge-Request in EU (Paris)
* http://localhost:4000/fetch_pricing_data?endRange=Inf
* http://localhost:4000/fetch_pricing_data?beginRange=0
* http://localhost:4000/fetch_pricing_data?usd=0.0850000000 && http://localhost:4000/fetch_pricing_data?pricePerUnit=0.0850000000  will Work same as alise 


* Sample Output

[

    {
        "description": "$6.0E-7  per Request for Lambda-Edge-Request in EU (Paris)",
        "beginRange": "0",
        "endRange": "Inf",
        "unit": "Request",
        "pricePerUnit": "0.0000006000",
        "effectiveDate": "2019-12-01T00:00:00Z"
    }
    
]
# For price range filter
* http://localhost:4000/fetch_pricing_data?beginRange=0&endRange=10240

* Sample output

[

    {
        "description": "$0.170 per GB - first 10 TB / month data transfer out (India)",
        "beginRange": "0",
        "endRange": "10240",
        "unit": "GB",
        "pricePerUnit": "0.1700000000",
        "effectiveDate": "2019-12-01T00:00:00Z"
    }
    
    {
        "description": "$0.085 per GB - first 10 TB / month data transfer out (Canada)",
        "beginRange": "0",
        "endRange": "10240",
        "unit": "GB",
        "pricePerUnit": "0.0850000000",
        "effectiveDate": "2019-12-01T00:00:00Z"
    }
]





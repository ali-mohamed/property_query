# Property Query

A simple Rails application has a single endpoint that accepts latitude, longitude, property type and marketing type and returns a list of properties within a 5 KM radius.

## Prerequisites

Install:
* Ruby 3.0.0
* Rails 6.1.4
* PostgreSQL (at least 9.6), check `config/database.yml.example`

## Gems

* `activerecord-postgres-earthdistance` is used for calculating distance and returning records within specific range.
* `interactor` is used to encapsulate business logic and use cases.
* `jsonapi-serializer` for serializing data objects to JSON.

## Database creation

* Copy `database.yml` file with `cp config/database.yml.example config/database.yml` and configure the `USERNAME` and `PASSWORD`.
* Create the database with `rake db:create`.
* Populate the database with data dump of properties records `psql -U USERNAME -d property_query_development -f properties.sql`.
* Run database migration to create `earthdistance` DB extensions with `rake db:migrate`.

## Tests

Run test suite with RSpec: `rspec --format documentation` and make sure, all tests passed.

## Server

* Start the Rails server with `rails s -p 3000`.
* Open Browser at `localhost:3000/properties?lng=LONGITUDE&lat=LATITUDE&property_type=PROPERTY_TYPE&marketing_type=MARKETING_TYPE`.

## API Documentation

**List Properties**
----
  Returns json data with all properties matching criteria of `property_type` and `marketing_type` within 5 KM radius from longitude `lng` and latitude `lat`.

* **URL**

  `/properties`

* **Method:**

  `GET`

* **Data Params**

  **Required:**

   * `lng: float`.
   * `lat: float`.
   * `property_type: string`. Has to be either `apartment` or `single_family_house`.
   * `marketing_type: string`. Has to be either `sell` or `rent`.

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{"data" : [{"id":"1","type":"property","attributes":{"house_number":12,"street":"Aachner Straße","city":"Berlin","zip_code":"12345","lat":"12.3456789","lng":"12.3456789","price":"100000.0"}}]}`

* **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** `{ "errors" : "No data found for given location" }` <br />
    **Reason:** when no properties found fulfilling the search criteria.

  * **Code:** 422 UNPROCESSABLE ENTITY <br />
    **Content:** `{ "errors" : "property_type":["is not included in the list"] }` <br />
    **Reason:** when one or more parameters passed is invalid.

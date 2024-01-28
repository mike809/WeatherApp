# Project Name

## Description

This is a Ruby on Rails application designed to provide weather forecast data based on user input. Users can enter an address, and the application will retrieve and display the current temperature for that location. For an enhanced experience, the application also provides extended forecast information.

To optimize performance and reduce unnecessary API calls, the application caches forecast details for each zip code for 30 minutes. Users are informed if the displayed data is pulled from the cache. This ensures that the application provides up-to-date weather information while maintaining efficient operation.

## Getting Started

### Prerequisites

- Ruby version: 3.2.2
- Rails version: 7.1.3
- System dependencies: The following gems are required for this project:
  - `gem 'geocoder'`: This gem is used to convert addresses into coordinates.
  - `gem 'httparty'`: This gem is used to make HTTP requests to the weather API.
  - Other gems specified in the Gemfile.

  - Install Yarn: `npm install --global yarn` (if not already installed)



### Installation

- Clone the repository
- Run `bundle install`
- Run `bundle exec rails db:create`
- Run `bundle exec rails db:migrate`

- Obtain a Google Places API key. You can get one from the [Google Cloud Console](https://console.cloud.google.com/).

- Add the Google Places API key to your Rails credentials. You can do this by running the following command in your terminal:

  ```bash
  EDITOR="nano" rails credentials:edit
  ```

  This will open your credentials file in the nano text editor. Add the following lines to the file:

  ```google:
  places_api_key: YOUR_GOOGLE_PLACES_API_KEY
  ```
  Replace "YOUR_GOOGLE_PLACES_API_KEY" with your out key.


- Run `bin/dev`  to start the development server

### Services

This application uses the `solid_queue` gem for caching forecast data. The cached data is stored in the application's database, so no external caching services are required. This makes the application easier to set up and maintain.


## Usage

The application features a single form with an address input field. This field uses the Google Places API for autocomplete, ensuring that users can easily and accurately input their addresses.

To use the application, simply provide a valid US address in the address input field and submit the form. The application will then display the current weather forecast for the provided address.

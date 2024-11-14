# Project Name - Band Search App

The Band Search App is a full-stack web application built using Ruby on Rails as the backend and React.js as the frontend. It allows users to search for music bands based on their city, listing bands that were founded in the past 10 years. The app also tries to detect the user’s location automatically and show results based on their city.

## Table of Contents

- [Technology Stack](#technology-stack)
- [Setup](#setup)
- [API Endpoints](#api-endpoints)

## Technology Stack

### RUBY
  Installed ruby version
- **Ruby 3.0.0**: Programming language used in Rails development.
  ### with RVM
  - \curl -sSL https://get.rvm.io -o rvm.sh
  - rvm install ruby-x.x.x
  ### with rbenv
  - curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
  - rbenv install rbenv-x.x.x

### RAILS
  Installed rails version
- **Rails 7.1.5**: Backend framework for web development.


### Postgresql
  Installed postgresql version
- **Postgresql**: Database management system.

### Prerequisites
  Needed to run the appplication on the machine:
  - ruby-3.0.0
  - rails-7.1.5
  - yarn-1.22.22

  1. Clone the repository:
  - git clone https://github.com/akshay2408/band_search_app

  2. `cd band_search_app`

  3. Run `bundle install`

  4. `create database.yml from example_database.yml and update the usename and password`

  5. Run `rails db:setup`

  6. Run `yarn install`

  7. Run `./bin/webpack-dev-server`

  8. Run `rails s`

## API Endpoints

## **NOTE**: Fetch bands from API based on city.
 ### `GET \bands?city`
  #### Request URL -
    localhost:3000/api/v1/bands?city=Germany

## **NOTE**: Fetch bands on initial load using the user's location.
 ### `GET \bands`
  #### Request URL -
    http://localhost:3000/api/v1/bands

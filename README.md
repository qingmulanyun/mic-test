# Address App

## App Information

- Language: Ruby 2.4.3
- Web: Rails 5.0.2
- DB: Sqlite
- Test: Rspec
- Env Vars: dotenv

## System Setup Information

1. Install ruby 2.4.3 via ``rvm install 2.4.3``
2. Apply ruby 2.4.3 via ``rvm use ruby-2.4.3``
3. Install dependencies ``bundle install``
4. Setup database ``rake db:setup``
5. Run unit tests ``rspec``
6. Start server ``rails s``
7. Go to the host with url ``http://localhost:3000/``

## Description

Basically it's building a simple UX Web app based on Ruby on Rails. It only has one resource ``Address`` with 3 routes:

1. Get /
2. Post /addresses/select
3. Get /addresses

- Structure 

    It's a typical MVC architectural pattern project with Rails default code base structure. I added a few new folders:
    
    1. `app/library` : Holds all the customized libraries. Here only created customized `Exceptions` module including all the customized Error and Error code.
    2. `app/services` : Micro services for internal usage. Extract logic code to service classes to DRY the controllers which should only focus on business logic. The service classes will be more reusable and easy to extend. 
    3. `lib/msats` : An external RESTful API client. Easy to use for calling external API. Easy to extend with more resources and endpoints.
    4. `config/street_type.yml` : Holds all the street_type mapping.
    
- Dependencies

    All the dependencies are displayed in `Gemfile`.
    
    1. `dotenv` for Env vars management. Make the external address API configurable.
    2. `faraday` for HTTP request client. Help to build the external address API client.
    3. `vcr` help to test with external API calls. It will record the real external API call details.
    

- Points

    1. Use environment vars, make app more configurable.
     
    2. Build external address API client. See everything as a resource. Make code more readable, reusable and easy to extend with other resources.
    
    3. Made customized `Exceptions` module with customized Error code and Error message. Rescue and handle all the Error in the base controller.
    
    4. Extract logic code to service classes to DRY the controllers which should only focus on business logic. If requirements have been changed, no need to modify controller part, only need to change the service classes.
    
    5. TDD. Followed TDD. Implement routes firstly, then implement all the unit test with Rspec and implement the contorller details at last.
    
    6. Use JSON to store `house_name_or_number` `street_name` `lot_or_unit` which have multi values for a single DB field. Then, create a few model methods for `address` model to access every single field like `house_number` `property_name` etc. In this way, it will solve the problem that the address fields may not be populated. 
    
    7. Store street_type format mapping into a YAML configure file. In order to solve the street_type format issue, from a data level perspective, we still need to store the exact street_type from API response which is a short string into database but display the human readable street type in view. So I store all the street_type mapping in a YAML file. Create a view helper with this YAML file and do the formatting.
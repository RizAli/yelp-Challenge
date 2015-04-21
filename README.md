# yelp-Challenge

The goal is to learn the Rails, focusing especially on:

Creating Rails applications
The structure of Rails apps (MVC, the router, helpers)
TDD in Rails, with RSpec & Capybara
Associations
Validations
AJAX in Rails

# Stage 1 - Specification

Duplicate the core functionality of Yelp - users should be presented with a list of restaurants which they can leave reviews for.

Visitors can create new restaurants using a form, specifying a name and rating
Restaurants can be edited and deleted
Visitors can leave reviews for restaurants, providing a numerical score (1-5) and a comment about their experience
The restaurants listings page should display all the reviews, along with the average rating of each restaurant
Validations should be in place for the restaurant and review forms - restaurants must be given a name and rating, reviews must be given a rating from 1-5 (comment is optional)

- New rail app  -  $ rails new yelp_clone -d postgresql -T
- Boot the server and migrate database: bin/rails s   , bin/rake db:create,  bin/rake db:create RAILS_ENV=test
- Gems for testing - rspec-rails / capybara
- $ bin/rails generate rspec:install
- require 'rails_helper' in restaurant_features_spec.rb  
(to allow me use capybara in testing env for the purpose of writing acceptance test)

top level acceptance test
###  First feature test - home page with a link
```  
  Error - No route matches [GET] "/restaurants - Indicates that we should add root in config routes.
``` 
- resources :restaurants      - Automatically creates paths for create, read, update and destroy methods.
```
  Error - uninitialized constant RestaurantsController
```
3. Controllers are bit like methods in a Sinatra server file - They contain 'verbs' that handle incoming requests and do something in response to them.
```
  bin/rails g controller restaurants
```
  This command generates restaurants_controller.rb in app/controllers
  
- running rspec now gives us the action/index error
```  
 The action 'index' could not be found for RestaurantsController
```
- refresh the local host and the error is now
``` 
Missing template restaurants/index
```
-  Creating views
  touch app/views/restaurants/index.html.erb

- the test still fails as there is no text on the page "Add a restaurant"
  ```
   expected to find link "Add a restaurant" but there were no matches
   ```
-  Now running rspec shows us a green test...Hurray

### The second test - creating a restaurant on the backend
```
uninitialized constant Restaurant
```
- In rails we use Rails gem ActiveRecord to create an object, which is stored in a database. In the second
test I have added Restaurant.create(name: 'KFC')
Now when we run rspec it gives us an error 'uninitialized constant Restaurant' which tells us that "Restaurant model is required'

#### Models and migration
```
bin/rails g model restaurant name:string rating:integer
```
this command generates something like this. In particular the above command includes properties
name adn rating for each restaurant. Each item automatically gets an ID.
```
      invoke  active_record
      create    db/migrate/20150421162659_create_restaurants.rb
      create    app/models/restaurant.rb
```
and it does two things
  - it creates a new model, which tells the app what a 'restaurant' is and what properties it has.
  - it creates a migration which contains instructions for Rake ('Ruby make') to update the database.


### n.b Model 'restaurant is singular', but the controller refers to 'restaurants'

running rspec now gives us an error of migration
``` 
(ActiveRecord::PendingMigrationError)
```
now we have a restaurant on the backend lets write a test to create it on the front end
## Creating a restaurant on the frontend








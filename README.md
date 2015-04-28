[![Build Status](https://travis-ci.org/RizAli/yelp-Challenge.svg?branch=yelp_development)](https://travis-ci.org/RizAli/yelp-Challenge)

[![Code Climate](https://codeclimate.com/github/RizAli/yelp-Challenge/badges/gpa.svg)](https://codeclimate.com/github/RizAli/yelp-Challenge)


[![Test Coverage](https://codeclimate.com/github/RizAli/yelp-Challenge/badges/coverage.svg)](https://codeclimate.com/github/RizAli/yelp-Challenge)



# yelp

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

<<<<<<< HEAD


||||||| merged common ancestors
=======
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

#### n.b Model 'restaurant is singular', but the controller refers to 'restaurants'


## Rendering restaurants in the view
Lets add a method in restaurant_controller.rb
```
def index
  @restaurants = Restaurant.all
end
```

This instance variable @restaurants can now be accessed in the index view.
now lets add in the view  app/views/restaurants/index.html.erb

```
<% if @restaurants.any? %>
  <% @restaurants.each do |restaurant| %>
    <h2> <%= restaurant.name %> </h2>
  <% end %>
<% else %>
  No restaurants yet
<% end %>

<a href="/restaurants/new">
```

So in summary our URL http://localhost:3000/restaurants hits the Rails routing system, which passes the request to the index action in the restaurants controller, which queries the database for any restaurant models. The controller then 'passes' (using some Rails magic) an instance variable containing all the restaurant models to the view, where they can be correctly formatted. The controller returns the resulting HTML back to the browser for display to the end user.


## Creating a restaurant on the frontend
```
context 'creating restaurants' do
  scenario 'prompts user to fill out a form, then displays the new restaurant' do
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq '/restaurants'
  end
end
```
running rspec now gives us an error of migration
```
       Capybara::ElementNotFound:
       Unable to find field "Name"
```
adding a path from the rails helper raises the following error of migration
```
(ActiveRecord::PendingMigrationError)
```

```
rspec raise this error: Unable to find field "Name"
after harcoding the path in the index.html.erb raises the following error
        AbstractController::ActionNotFound:
        The action 'new' could not be found for RestaurantsController
```
The action 'new' could not be found for RestaurantsController indicates that a new method restaurant.controller.rb
needs to be added alongside index method.
```
def new
end
```
running rspec now gives us the following error, and this error means that our new method doesn't have a view associated with it.
```
ActionView::MissingTemplate:
       Missing template restaurants/new, application/new with {:locale=>[:en], :formats=>[:html], :variants=>[], :handlers=>[:erb, :builder, :raw, :ruby, :coffee, :jbuilder]}. Searched in:
         * "/Users/rizcube/Documents/makers/yelp-challenge/app/views"

```

Lets create a new file in app/view/restaurants/new.html.erb

running rspec now raises the following error
```
Failure/Error: fill_in 'Name', with: 'KFC'
     Capybara::ElementNotFound:
       Unable to find field "Name"
```



##  Making forms in Rails- form_for, create, and permit
```
<%= form_for Restaurant.new do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>

```
```
<%= form_for Restaurant.new do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```
>>>>>>> master

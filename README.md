# Memory Game

Simple rails web application for users to play memory game.

### Demo

A demo of this can be seen at
http://memorygame-demo.herokuapp.com


### Features

* Saves the state of users game, allowing them to come back to play over time.
* Uses UUID to track each game's progress.
* User's game progress is isolated to themselves, harder to guess other's game identifier.
* Easier to generate reports on user progress.
* Simple admin interface to set the cards content.
* Email notifications

### Setup

Clone the repository
```
https://github.com/avinash-vllbh/memory-game.git
```
Run bundle install to setup all the gem's required for the repository
```
bundle install
```

Add the appropriate database configurations to app/config/database.yml file
http://guides.rubyonrails.org/configuring.html#configuring-a-database

Run db:setup, to setup the database along with schema and any seed provided in app/db/seed.rb
```
rake db:setup
```

Add appropriate action mailer settings in respective [RAILS_ENV].rb files for the "notify user" functionality to work

### Testing

Rspec and Fixtures are used for unit testing. They are installed when bundler is run.

You can run the test suite by running rspec from command line.
```
rspec
```
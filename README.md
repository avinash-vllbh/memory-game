# Memory Game

Simple rails web application for users to play memory game.

### Demo

A demo of this can be seen at
http://memorygame-demo.herokuapp.com


### Features

* Randomized board for every game, which keeps the game interesting.
* Saves the state of users game, allowing them to come back to play over time.
* Uses UUID to track each game's progress.
* Using UUID allow's user's game progress to be isolated to themselves, also makes it harder to guess other's game identifier.
* Easier to generate reports on user progress.
* Simple admin interface to add or edit the card's content.
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

Although this repository uses PostgreSQL as it's database, you can use anything that suits you, provided you change the gem's in Gemfile accordingly.

One worth noting featuring is "games" table uses UUID as it's primary key which also helps in tracking users progress and keeps other user's progress partially secure. Rails supports UUID as primary key for postgresql by default. Make sure if postgresql is not the database you are planning to use then it's setup right for using UUID's as primary key option.

Run db:setup, to setup the database along with schema and any seed provided in app/db/seed.rb
```
rake db:setup
```

Add appropriate action mailer settings in respective [RAILS_ENV].rb files for the "games#notify_user" functionality to work

### Testing

Rspec and Fixtures are used for unit testing. They are installed when bundler is run.

You can run the test suite by running rspec from command line.
```
rspec
```
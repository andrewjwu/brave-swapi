# brave-swapi

This application features a single web page that allows users to browse through the [Star Wars API](https://swapi.co/).

**Demo:** https://still-mountain-76497.herokuapp.com/

## Requirements

* PostgreSQL
* Ruby 2.4.4

## Setup

Install [RVM](https://rvm.io/) and Ruby.

> This section can be skipped if another Ruby version manager is preferred.

```bash
# rvm installation instructions can be found at https://rvm.io/
$ rvm install 2.4.4

# git checkout and cd into the project directory
# the .ruby-gemset file should automatically create a gemset, if not:
$ rvm use --create --ruby-version 2.4.4@brave
```

Set up the application.

```bash
$ gem install bundler
$ bundle install

# macOS Postgres.app users will encounter an error and will need to install 
# the pg gem by specifying the path to their pg_config. example:
# gem install pg -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/9.6/bin/pg_config

$ rails db:create
$ rails db:migrate
$ rails server
```

Navigate to http://localhost:3000 and browse the API.

## Testing

Run the test suite:

```bash
$ rails test
```

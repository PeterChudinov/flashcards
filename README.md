# mkdev
flashcards

[![Build Status](https://travis-ci.org/PeterChudinov/flashcards.svg?branch=master)](https://travis-ci.org/PeterChudinov/flashcards) [![Code Climate](https://codeclimate.com/github/PeterChudinov/flashcards/badges/gpa.svg)](https://codeclimate.com/github/PeterChudinov/flashcards) [![Test Coverage](https://codeclimate.com/github/PeterChudinov/flashcards/badges/coverage.svg)](https://codeclimate.com/github/PeterChudinov/flashcards/coverage)

### What it is
Easiest way to learn German with English.

### To try it out:

You would need
 - Ruby >= 2.3.1
 - Rails >= 5
 - imagemagick (you can get it by running `brew install imagemagick`)
 - any fresh PostgreSQL

### To set it up

1. `git clone` the repo to your local machine
2. `rake secret` to get tokens for your `secret.rb`
3. Create an S3 bucket for picture storage and put the keys into `application.yml` (optional)
4. Create a pg database and describe it in your `database.yml` file
5. Run `bundle install` from within the repo directory
6. Run `rake db:setup` to migrate the db and fill it in with test data.
7. Sign up (login) with your credentials or Twitter and run `rake tossup`
8. It's all set! Good luck learning languages!
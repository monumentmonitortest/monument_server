# README
This application is design to collate and store photographic submissions to the [Monument Monitor project](www.monumentmonitor.co.uk). It is a ruby on rails based application built with a react front end and allows for the easy upload, storage and sorting of submissions to citizen heritage science projects.

This project has been forked for the [Dinosaur Monitor project](https://github.com/Rosie-Brigham/dino_monitor). 
Hosting is reccomended on either AWS or heroku

# Installation
To install this application locally, clone/fork the code onto your machine as usual and install the relevant libraries using `bundle install`.

You will need to have the relevant versions of [rails](https://guides.rubyonrails.org/v5.0/getting_started.html) and [ruby](https://rvm.io/) installed. Some missing packages can be easily installed using [homebrew](https://brew.sh/)

## Database Setup
This application runs on a [postgres](https://postgresapp.com/) database, we reccomend the Postgres.app for easy database management (once it's up, it runs quietly in the background)
Follow instructions [here](https://medium.com/@noordean/setting-up-postgresql-with-rails-application-357fe5e9c28) to setup the database, ignoring step 3 as 'pg' is already within the Gemfile.

To create sites within the database, edit the [seeds](https://github.com/monumentalconservation/monument_server/blob/master/db/seeds.rb) file, inserting approriate information about your case study sites. To run the seed file run `$ rake db:seed` from the terminal.

## Environment setup

Create a .env file for storing local environmental variables, copy this from the .exampleenv file withing the base directory. *Ensure this is included in the '.gitignore' file before committing on git*.


A Twitter API account is required to retrieve images from twitter, a S3 account for image storage on AWS and a google account for metrics and email services.

Fill your credentials for the above in the .env file accordingly.

# Running Locally
## Run React fonrend:
`$  sh -c rm -rf public/packs/* || true && bundle exec rake react_on_rails:locale && bin/webpack-dev-server`

OR

`$ sh -c 'rm -rf public/packs/* || true && bundle exec rake react_on_rails:locale && bin/webpack -w'`

## Run server:

bs rails s

## Download backup and restore DB:
heroku pg:backups:capture --app monument-monitor
heroku pg:backups:download --app monument-monitor
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U HEROKU_USERNAME -d DEVELOPMENT_DATABASE_NAME latest.dump

Create dump file
PGPASSWORD=mypassword pg_dump -Fc --no-acl --no-owner -h localhost -U HEROKU_USERNAME PRODUCTION_DATABASE_NAME > ms_prod.dump

# Uploading images

## Twitter
Images can be uploaded automatically from Twitter using the Twitter API. This can be run manually from the terminal by running:

`$ bin/rails runner 'lib/twitter_script.rb'`

Alternatively it can be run using a cron job in your chosen hosting platform (i.e scheduler in Heroku).
As the Twitter API only provides the past 7 days of tweet data free of charge, we reccomend running it at least once a week.

## Instagram
Images can be uploaded from instagram by uploading a json file of an instragm scrape, using the instamanger tool.

- Install instamancer onto your machine, follow these [directions](https://github.com/ScriptSmith/instamancer)
- Run the following script from your terminal: 
`instamancer hashtag YOUR_HASHTAG --full --logging=info --visible`. 
This will create a JSON file containing data on all posts using your particular hastag.
- Upload the file into the server using the 'admin/insta_upload' view. You can select from which date uploads should be taken, as duplicates can be common as post IDs can change.

## Email and Whatsapp

WhatsApp and emil images can be uploaded manually using the bulk upload form, found at 'admin/bulk_upload'

# Reporting

Reports can be generated in real time for submissions to the project in the 'admin/results' view.


# API

Information regarding the submissions can be obtained via the front end or through the API. Endpoints for this are as follows. (Authentication for the API is currently ongoing)

### Retrieve submission data
GET 'ROOT/submissions'

Returns paginated json object containing latest submission information, including URL for images


GET 'ROOT/submissions/submission_data'

Returns unpaginated json object containing submission information, not including URLs for images
      
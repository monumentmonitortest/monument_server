# README


# Running Locally
## Run React fonrend:
sh -c rm -rf public/packs/* || true && bundle exec rake react_on_rails:locale && bin/webpack-dev-server

## Run server:

bs rails s

## Download backup and restore DB:
heroku pg:backups:capture
heroku pg:backups:download
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U roo -d monumental_server_development latest.dump

Create dump file
PGPASSWORD=mypassword pg_dump -Fc --no-acl --no-owner -h localhost -U roo monumental_sever_production > ms_prod.dump


## Run instagram scraper
instamancer hashtag monumentmonitor --full --logging=info --visible
set -o errexit

bundle install
bundle exec rails db:create
bundle exec rails db:migrate
yarn install
bundle exec rails assets:precompile

if [ "$RAILS_ENV" = "production" ]; then
  ./bin/webpack-dev-server &
fi

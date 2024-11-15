set -o errexit

bundle install
bundle exec rails db:migrate
rm -rf public/packs
yarn install
bundle exec rails assets:precompile

git checkout -b local
git add .
git commit -m "Saving any local changes"
echo "Downloading latest changes"
git fetch
echo "Updating to latest release"
git merge origin/release -m "Updating to latest release code"
bundle install --deployment --without development test
bundle exec rake assets:precompile db:migrate RAILS_ENV=production
passenger-config restart-app $(pwd)

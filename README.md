# README

To get started:
Install Ruby
Clone the repo
sudo apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev libsqlite3-dev ruby
sudo gem install bundler
bundle install
rake db:migrate
RAILS_ENV=production rake secret
  Put this output into secrets.yml and do not share this file
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rake assets:precompile
Edit start.sh and/or startdev.sh to have proper IP
Edit public/index.html to have the right user settings
Edit public/index.css and assets/stylesheets/application.css to modify colors if needed
run start.sh to screen a screen with Rails running

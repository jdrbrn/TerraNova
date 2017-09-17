# README

TerraNova is a Ruby on Rails webapp designed to manage territories. It can be linked to multiple versions of itself to manage multiple territory types with only one end user interface.

TerraNova is configured to be deployed using Passenger.

TerraNova require yarn to be installed to make rails happy. Please follow this guide: https://yarnpkg.com/en/docs/install

To get started I recommend following this guide: https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/aws/nginx/oss/launch_server.html this link is to a guide for an Amazon EC2 deploy using nginx.

Files to edit are:
Edit public/index.html to have the right user settings
Edit public/index.css and assets/stylesheets/application.css to modify colors if needed

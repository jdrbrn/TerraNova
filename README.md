# README

TerraNova is a Ruby on Rails webapp designed to manage territories. It can be linked to multiple versions of itself to easily manage multiple databases in what is seemingly one user interface.

TerraNova is developed using Ruby 2.3.3, and has not been tested under any other version

TerraNova is configured to be deployed using Passenger.

TerraNova require yarn to be installed to make rails happy. Please follow this guide: https://yarnpkg.com/en/docs/install

To get started I recommend following this guide: https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/aws/nginx/oss/launch_server.html this link is to a guide for an Amazon EC2 deploy using nginx. When pulling the code, you will want to use "git clone git://github.com/jdrbrn/TerraNova --branch=release code" instead of "git clone git://github.com/username/myapp.git code"


After following that guide to get the base install the following steps will create allow you to have a local install and be able to simply update:

Edit the following files:
TerraNovaConfig.json to configure the server as desired. Please see the wiki page for more information on the config file.

To update run UpdateLocal.sh when logged in as the application user which will pull the latest released code. If you have made any substantial changes you may need to manually merge the update and the local codebases.

Once deployed you will need to add territories by going to the territory database(linked from the main page), and individually adding them. Once added please check them out/in to get them added to the proper category.
# README

TerraNova is a Ruby on Rails webapp designed to manage territories. It can be linked to multiple versions of itself to manage multiple territory types with only one end user interface.

TerraNova is developed using Ruby 2.3.3, and has not been tested under any other version

TerraNova is configured to be deployed using Passenger.

TerraNova require yarn to be installed to make rails happy. Please follow this guide: https://yarnpkg.com/en/docs/install

To get started I recommend following this guide: https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/aws/nginx/oss/launch_server.html this link is to a guide for an Amazon EC2 deploy using nginx. When pulling the code, you will want to use "git clone git://github.com/jdrbrn/TerraNova --branch=release code" instead of "git clone git://github.com/username/myapp.git code"


After following that guide to get the base install the following steps will create allow you to have a local install and be able to simply update:

Edit the following files:
app/views/report/index.html.erb to have the right user settings

public/index.css and assets/stylesheets/application.css to modify colors if needed

app/views/dncs/print.html.erb to have the correct sizing. The default settings generate a card that is 6.75in wide. The relevant lines are 20,26 and for more detailed size modifications 55-60.

To update run UpdateLocal.sh when logged in as the application userwhich will pull the latest released code. If you have made any substantial changes you may need to manually merge the update and the local codebases.


Once deployed you will need to add territories by going to the territory database(linked from the main page), and individually adding them. Once added please check them out (and in if applicable) to get them added to the proper category and to print on the generated worksheet.

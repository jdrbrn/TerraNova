# README

TerraNova is a Ruby on Rails webapp designed to manage territories. It can be linked to multiple versions of itself to manage multiple territory types with only one end user interface.

TerraNova is developed using Ruby 2.3.3, and has not been tested under any other version

TerraNova is configured to be deployed using Passenger.

TerraNova require yarn to be installed to make rails happy. Please follow this guide: https://yarnpkg.com/en/docs/install

To get started I recommend following this guide: https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/aws/nginx/oss/launch_server.html this link is to a guide for an Amazon EC2 deploy using nginx.

Files to edit are:
app/views/report/index.html.erb to have the right user settings

public/index.css and assets/stylesheets/application.css to modify colors if needed

app/views/dncs/print.html.erb to have the correct sizing. The default settings generate a card that is 6.75in wide. The relevant lines are 20,26 and for more detailed size modifications 55-60.



Once deployed you will need to add territories by going to the territory database(linked from the main page), and individually adding them. Once added please check them out (and in if applicable) to get them added to the proper category and to print on the generated worksheet.

# MediSafe Dashboard Project
This is Medisafe''s Dashboard Project

## Installation

In order to install Medisafe Dashboard web application you need to follow the following steps:
* Install node (sudo apt-get install node)
* Install git (sudo apt-get install git)
* Install MongoDB, if a local database is used. If a remote database is used, than it has to be configured (but more on that later) ([how to install mongodb on Ubuntu](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/))
* Clone the latest git repository (git clone <url to git repository>)
* Install all of the required node libraries (sudo npm install)
* Clone the latest database
* Run the database (sudo mongod)
* Copy the medisafeDashboard.conf file from ./tools to /etc/init.d/
* Run
* Set the environment varialbes of the machine
* Start the deamon runing the server (sudo start medisafeDashboard)

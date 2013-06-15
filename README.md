# Demo Rails Vagrant Chef

## Dependencies

You'll need to have the following tools installed for this to work

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://vagrantup.com/)

## Instructions
The project is a my demo, based on [339-chef-solo-basics](http://railscasts.com/episodes/339-chef-solo-basics) from railscasts.com to have look at Chef Solo basic, it helps you to understand Chef Solo as quick as possible.
The demo app builds two boxes, web server and postgresql server Ubuntu 12.04 server basically, using virtualbox. Also I will generate simple rails app and use Capistrano to deploy to the Websever instance soon.

### Web server (Ruby On Rails)

  Build a web instance:

    vagrant up web

  Access with ip: 192.168.33.20

### Postgresql server

  Build a database instance:

    vagrant up database

  Access with ip: 192.168.33.25

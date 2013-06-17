# Demo Rails Vagrant Chef

## Dependencies

You'll need to have the following tools installed for this to work

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://vagrantup.com/)

## Instructions
The project is a my demo, based on [339-chef-solo-basics](http://railscasts.com/episodes/339-chef-solo-basics) from railscasts.com to have look at Chef Solo basic, it helps you to understand Chef Solo as quick as possible.
The demo app builds two boxes, web server and postgresql server Ubuntu 12.04 server basically, using virtualbox. And a simple rails app that's using Capistrano to deploy to the Websever instance.

### Web server (Ruby On Rails)

  Build a web instance:

    vagrant up web

  Access with ip: 192.168.33.20

### Postgresql server

  Build a database instance:

    vagrant up database

  Access with ip: 192.168.33.25

### Deployment Rails app
  Navigate to blog directory
  Enter the command:

    cap deploy:setup #to setup deployment
    cap deploy:migrates #to deploy and migrate

  Now, you can visit 192.168.33.20 on browser.

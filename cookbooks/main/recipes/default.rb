#package "zsh"

#include_recipe "nginx::source"


user "deployer" do
  password "$1$6t8mGT2j$tobx3nBoA8sq.aGL6e9R20"
  gid "admin"
  home "/home/deployer"
  supports :manage_home => true
  #shell "/bin/zsh"
end

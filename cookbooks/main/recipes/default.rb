package "libshadow-ruby1.8"
package "zsh"
include_recipe "main::install_rbenv"
#include_recipe "nginx::source"

# node refer to Vagrant file at chef.json = values
# http://wiki.opscode.com/display/chef/resources#Resources-User
#user node[:user][:name] do
#  action :remove
#end

user node[:user][:name] do
  password node[:user][:password]
  gid "admin"
  home "/home/#{node[:user][:name]}"
  supports :manage_home => true
  shell "/bin/zsh"
end

##http://wiki.opscode.com/display/chef/resources#Resources-Template
template "/home/#{node[:user][:name]}/.zshrc" do |variable|
  source "zshrc.erb"
  owner node[:user][:name]
end

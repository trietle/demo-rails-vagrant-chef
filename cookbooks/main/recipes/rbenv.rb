#install rbenv
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby "2.0.0-p195" do
  ruby_version "2.0.0-p195"
  force false
  global true #set as global
end

rbenv_gem "passenger" do
  version node[:nginx][:passenger][:version]
  ruby_version "2.0.0-p195"
end

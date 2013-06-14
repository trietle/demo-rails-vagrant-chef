include_recipe "nginx::source"

directory "/var/www" do
  owner node['nginx']['user']
end

directory "/var/www/nginx-default" do
end

file "/var/www/nginx-default/index.html" do
  owner node['user']['name']
  content "<h1>Hello World</h1>"
end

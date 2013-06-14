set['rbenv']['rubies'] = [ "2.0.0-p195" ]

set['rbenv']['gems'] = {
  '2.0.0-p195' => [
    { 'name'    => 'bundler' }
  ]
}

set['ruby_build']['upgrade'] = true

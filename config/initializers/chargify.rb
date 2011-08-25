case
when Rails.env.production?
  Padelotron::Application.config.chargify = {
    :username => 'ZVY9HZVFayyNi1C9gPxa', :password => 'x'}
when Rails.env.development?
  Padelotron::Application.config.chargify = {
    :username => 'ZVY9HZVFayyNi1C9gPxa', :password => 'x'}
when Rails.env.test?
  Padelotron::Application.config.chargify = {
    :username => 'ZVY9HZVFayyNi1C9gPxa', :password => 'x'}
end

Chargify.configure do |c|
  c.subdomain = 'tendel'
  c.api_key   = 'ZVY9HZVFayyNi1C9gPxa'
end
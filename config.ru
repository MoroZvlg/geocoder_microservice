require_relative './config/environment'

ApplicationLoader.load_app!

map '/geo' do
  run GeoRoutes
end



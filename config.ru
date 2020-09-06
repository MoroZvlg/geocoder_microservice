require_relative './config/environment'

use Rack::Ougai::LogRequests, Application.logger
ApplicationLoader.load_app!

map '/geo' do
  run GeoRoutes
end



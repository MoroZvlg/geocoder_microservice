require 'csv'

module Geocoder
  extend self

  DATA_PATH = File.join(ApplicationLoader.root, "db/data/city.csv")

  def geocode(city)
    coordinates = data[city]
    Application.logger.info(
        "FetchCoordinates for #{city}",
        city: city,
        coordinates: coordinates
    )
    coordinates
  end

  def data
    @data ||= load_data!
  end

  private

  def load_data!
    @data = CSV.read(DATA_PATH, headers: true).inject({}) do |result, row|
      city = row['city']
      lat = row['geo_lat'].to_f
      lon = row['geo_lon'].to_f
      result[city] = [lat, lon]
      result
    end
  end
end

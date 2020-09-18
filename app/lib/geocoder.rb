require 'csv'

module Geocoder
  extend self

  DATA_PATH = File.join(ApplicationLoader.root, "db/data/city.csv")

  def geocode(city)
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    coordinates = data[city]
    spent = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - starting) * 1000).round
    Application.logger.info(
        "FetchCoordinates for #{city}",
        city: city,
        coordinates: coordinates
    )
    Metrics.geocoding_duration_milliseconds.observe(spent, labels: { city: city })
    Metrics.geocoding_requests_total.increment(labels: { result: coordinates.present? ? "success": "failure" })
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

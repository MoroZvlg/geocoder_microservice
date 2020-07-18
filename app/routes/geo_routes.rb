class GeoRoutes < Application
  namespace '/v1' do
    get '/' do
      geocode_params = validate_with!(PermitParams::GeocodeParams)
      result = Geocoder.geocode(geocode_params[:city])
      if result.present?
        status 200
        json meta: { lat: result[0], lon: result[1] }
      else
        status 404
        error_response(I18n.t(:unknown_city, scope: 'api.errors'))
      end
    end

  end
end

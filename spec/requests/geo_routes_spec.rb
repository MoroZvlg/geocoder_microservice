RSpec.describe GeoRoutes, type: :request do
  describe 'GET /geo' do
    context 'missing parameters' do
      it 'returns an error' do
        get '/v1/'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:geo_params) do
        {
            sity: '',
        }
      end

      it 'returns an error' do
        get '/v1/', geo_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
                                               {
                                                   'detail' => 'Parameter missing'
                                               }
                                           )
      end
    end

    context 'valid parameters' do
      before do
        allow(Geocoder).to receive(:geocode).and_return([100.to_d, 50.to_d])
      end
      let(:geo_params) do
        {
            city: 'City',
        }
      end

      it 'creates a new ad' do
        get '/v1/', geo_params
        expect(Geocoder).to have_received(:geocode).with('City')
        expect(last_response.status).to eq(200)
        expect(response_body['meta']).to eq({'lat' => 100.to_d.to_s, 'lon' => 50.to_d.to_s})
      end
    end

    context 'unknown sity' do
      before do
        allow(Geocoder).to receive(:geocode).and_return(nil)
      end
      let(:geo_params) do
        {
            city: 'UnknwonCity',
        }
      end
      it 'creates a new ad' do
        get '/v1/', geo_params
        expect(last_response.status).to eq(404)
        expect(Geocoder).to have_received(:geocode).with('UnknwonCity')
        expect(response_body['errors']).to include(
                                               {
                                                   'detail' => 'Unknown city'
                                               }
                                           )
      end
    end

  end
end
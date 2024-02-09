require 'rails_helper'

RSpec.describe WeatherForecastService, type: :service do
  let(:address) { '123 Main St, Anytown, USA' }
  let(:service) { WeatherForecastService.new(address) }

  describe '#call' do
    context 'when the address is valid' do
      before do
        allow(Geocoder).to receive(:search).and_return([double(zipcode: '12345', coordinates: [1.0, 1.0], postal_code: '12345')])
        allow(HTTParty).to receive(:get).and_return(double(success?: true, parsed_response: { 'properties' => { 'forecast' => 'forecast_url', 'periods' => [] } }))
      end

      it 'returns a forecast with the correct location' do
        forecast = service.call
        expect(forecast.location.zipcode).to eq('12345')
      end

      it 'returns a forecast with periods' do
        forecast = service.call
        expect(forecast.periods).to eq([])
      end
    end

    context 'when the address is invalid' do
      before do
        allow(Geocoder).to receive(:search).and_return([])
      end

      it 'returns a forecast with no location' do
        forecast = service.call
        expect(forecast.location).to be_nil
      end
    end

    context 'when the API request fails' do
      let(:response) { double(success?: false) }
      before do
        allow(Geocoder).to receive(:search).and_return([double(zipcode: '12345', coordinates: [1.0, 1.0], postal_code: '12345')])
        allow(response).to receive(:[]).with('title').and_return('Error message')
        allow(HTTParty).to receive(:get).and_return(response)
      end

      it 'returns a forecast with errors' do
        forecast = service.call
        expect(forecast.errors.first).to include('Error message')
      end
    end
  end
end

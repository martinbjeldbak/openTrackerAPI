require 'spec_helper'

describe 'laps API' do
  describe 'POST /api/v1/sessions/:session_id/laps' do
    let (:s) { FactoryGirl.create(:session) }

    it 'allows creation of a lap upon legal input' do
      request_headers = { 'Content-Type' => 'application/json',
                          'HTTP_AUTHORIZATION' => "Token token=\"#{s.key.key}\""}
      payload = {
          lap: {
              lap_nr: 2
          }
      }.to_json

      #post api_v1_session_laps_path(s.id), payload, request_headers
      post "/api/v1/sessions/#{s.id}/laps", payload, request_headers

      expect(response).to be_success

      expect(Lap.count).to eql 1
      expect(Lap.first.lap_nr).to eql 2
      expect(Lap.first.session).to eql s
    end
  end

end
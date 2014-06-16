require 'spec_helper'
include Helpers

describe 'laps API' do

  describe 'POST /api/v1/sessions/:session_id/laps' do
    let (:s) { FactoryGirl.create(:session) }

    it 'allows creation of a lap upon legal input' do

      payload = {
          lap: {
              lap_nr: 2
          }
      }.to_json

      post api_v1_session_laps_path(s.id), payload, session_auth_header(s)

      expect(response).to be_success

      expect(Lap.count).to eql 1
      expect(Lap.first.lap_nr).to eql 2
      expect(Lap.first.session).to eql s
      expect(Lap.first.id).to eql json['id']
    end
  end

end
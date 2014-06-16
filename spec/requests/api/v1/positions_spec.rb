require 'spec_helper'
include Helpers

describe 'positions API' do
  describe 'POST /api/v1/sessions/:session_id/lap/:lap_id/positions' do
    let (:lap) { FactoryGirl.create(:lap) }

    it 'allows creation of a lap upon legal input' do
      post api_v1_session_lap_positions_path(lap.session.id, lap.id),
           {x: -28, y: 5, z: 0 }.to_json,
           session_auth_header(lap.session)

      expect(response).to be_success
    end
  end
end
require 'spec_helper'
include Helpers

describe 'positions API' do
  describe 'POST /api/v1/sessions/:session_id/lap/:lap_id/positions' do
    let (:lap) { FactoryGirl.create(:lap) }

    it 'allows creation of a lap upon legal input' do
      post api_v1_session_lap_positions_path(lap.session.id, lap.id),
           { x: -28, y: 5, z: 2.5, speed: 3.552, rpm: 1402.3345, gear: 5, on_gas: 0,
             on_brake: 1, on_clutch: 0, steer_rot: -6.28318531 }.to_json,
           session_auth_header(lap.session)

      expect(response).to be_success
      pos = Position.last

      expect(pos.lap).to eq lap
      expect(pos.x).to eq -28
      expect(pos.y).to eq 5
      expect(pos.z).to eq 2.5
      expect(pos.speed).to eq 3.552
      expect(pos.rpm).to eq 1402.3345
      expect(pos.gear).to eq 5
      expect(pos.on_gas).to eq false
      expect(pos.on_brake).to eq true
      expect(pos.on_clutch).to eq false
      expect(pos.steer_rot).to eq -6.28318531
    end
  end
end
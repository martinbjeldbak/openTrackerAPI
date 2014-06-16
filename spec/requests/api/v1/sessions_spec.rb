require 'spec_helper'
include Helpers

describe 'Sessions API' do

  describe 'GET /api/v1/sessions' do
    it 'returns all the sessions' do
      FactoryGirl.create_list :session, 10

      get '/api/v1/sessions'

      expect(response).to be_success
      expect(json.length).to eq(10)
    end
  end

  describe 'PUT /api/v1/sessions/:id' do
    let(:s) { FactoryGirl.create :session }

    it 'updates using an api key' do

      end_time = Time.now
      data = {session: { ended_at: end_time }}.to_json

      patch "/api/v1/sessions/#{s.id}", data, session_auth_header(s)

      expect(response.status).to_not eq 401
    end
  end

  describe 'GET /api/v1/sessions/:id' do
    it 'returns a requested session' do
      s = FactoryGirl.create :session

      get "/api/v1/sessions/#{s.id}", {}, json_request_header

      expect(response).to be_success

      expect(json['started_at']).to eq s.started_at
      expect(json['ot_version']).to eq s.ot_version
      expect(json['ac_version']).to eq s.ac_version
      expect(json['user_id']).to eq s.user.id
      expect(json['id']).to eq s.id
      expect(json['key']['key']).to eq s.key.key
    end
  end

  describe 'POST /api/v1/sessions' do

    describe 'when user does not exist' do
      it 'returns user cannot be found error' do
        session_params = {
          session: {
            version: '0.1',
          }
        }.to_json

        post '/api/v1/sessions', session_params, json_request_header

        expect(response.status).to eq 404
        expect(json['errors']).to eq 'Could not find user'
      end
    end

    describe 'when a user does exist' do
      let (:u) { FactoryGirl.create :user }

      it 'does not POST a valid ot version' do
        post '/api/v1/sessions', { session: { user_id: u.id, user_agent: 'rspec', ac_version: '1.0', ot_version: '0.0' } }.to_json, json_request_header

        expect(json['errors']['ot_version']).to eql(['0.0 is not a valid OpenTracker version'])
      end

      it 'returns a new API key' do
        post '/api/v1/sessions', { session: { user_id: u.id, ot_version: '0.1', user_agent: 'rspec', ac_version: '1.0' } }.to_json, json_request_header

        expect(response).to be_success
        expect(json['key']['key']).to eq u.sessions.first.key.key
      end
    end
  end
end
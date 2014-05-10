require 'spec_helper'

describe 'Sessions API' do

  describe 'GET /api/v1/sessions' do
    it 'returns all the sessions' do
      FactoryGirl.create_list :session, 10

      get '/api/v1/sessions'

      expect(response).to be_success
      expect(json.length).to eq(10)
    end
  end

  describe 'GET /api/v1/sessions/:id' do
    it 'returns a requested session' do
      s = FactoryGirl.create :session

      get "/api/v1/sessions/#{s.id}", {}, { Accept: 'application/json' }

      expect(response).to be_success

      expect(json['key']).to eq s.key
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

        request_headers = {
          Accept: 'application/json',
          'Content-Type' => 'application/json'
        }

        post '/api/v1/sessions', session_params, request_headers

        expect(response.status).to eq 404
      end
    end


    it 'returns a new API key' do
      u = FactoryGirl.create :user

      request_headers = {
        'Content-Type' => 'application/json'
      }

      post '/api/v1/sessions', { session: { user_id: u.id, version: '0.2' } }.to_json, request_headers

      expect(response).to be_success
      expect(json['key']).to eq u.sessions.first.key
    end
  end
end
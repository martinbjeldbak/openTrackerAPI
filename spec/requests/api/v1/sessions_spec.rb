describe 'Sessions API' do
  describe 'GET /api/v1/sessions' do
    it 'returns all the sessions' do
      FactoryGirl.create_list :session, 10

      get '/api/v1/sessions'

      expect(response).to be_success
      expect(json.length).to eq(10)
    end
  end

  describe 'GET /api/vi1/sessions/:id' do
    it 'returns a requested session' do
      s = FactoryGirl.create :session

      get "/api/v1/sessions/#{s.id}", {}, { Accept: 'application/json' }

      expect(response).to be_success

      expect(json['key']).to eq s.key
    end
  end

  describe 'POST /api/v1/sessions' do
    it 'returns a new API key' do
      #post '/api/v1/sessions'
    end
  end
end
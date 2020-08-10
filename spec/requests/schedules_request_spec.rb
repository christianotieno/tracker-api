require 'rails_helper'

RSpec.describe 'Schedules API', type: :request do
  # add chedule owner
  let(:user) { create(:user) }
  let!(:schedules) { create_list(:schedule, 10, created_by: user.id) }
  let(:schedule_id) { schedules.first.id }

  # authorize request
  let(:headers) { valid_headers }
  describe 'GET /schedules' do
    # update request with headers
    before { get '/schedules', params: {}, headers: headers }

    it 'returns schedules' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /schedules/:id' do
    before { get "/schedules/#{schedule_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the schedule' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(schedule_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:schedule_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Schedule/)
      end
    end
  end

  describe 'POST /schedules' do
    let(:valid_attributes) do
      # send json payload
      { title: 'Excercise', created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/schedules', params: valid_attributes, headers: headers }

      it 'creates a schedule' do
        expect(json['title']).to eq('Excercise')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/schedules', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /shedules/:id' do
    let(:valid_attributes) { { title: 'Read' }.to_json }

    context 'when the record exists' do
      before { put "/schedules/#{schedule_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /schedules/:id' do
    before { delete "/schedules/#{schedule_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

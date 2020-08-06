require 'rails_helper'

RSpec.describe 'Schedules API', type: :request do
  # initialize test data
  let!(:schedules) { create_list(:schedule, 10) }
  let(:schedule_id) { schedules.first.id }

  # Test suite for GET /schedules
  describe 'GET /schedules' do
    # make HTTP get request before each example
    before { get '/schedules' }

    it 'returns schedules' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /schedules/:id
  describe 'GET /schedules/:id' do
    before { get "/schedules/#{schedule_id}" }

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

  # Test suite for POST /schedules
  describe 'POST /schedules' do
    # valid payload
    let(:valid_attributes) { { title: 'Excercise', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/schedules', params: valid_attributes }

      it 'creates a schedule' do
        expect(json['title']).to eq('Excercise')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/schedules', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /schedules/:id
  describe 'PUT /shedules/:id' do
    let(:valid_attributes) { { title: 'Read' } }

    context 'when the record exists' do
      before { put "/schedules/#{schedule_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /schedules/:id
  describe 'DELETE /schedules/:id' do
    before { delete "/schedules/#{schedule_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

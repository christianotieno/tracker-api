require 'rails_helper'

RSpec.describe 'Schedule API' do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:schedules) { create_list(:schedule, 10, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { schedules.first.id }

  # Test suite for GET /users/:user_id/schedules
  describe 'GET users/:user_id/schedules' do
    before { get "/users/#{user_id}/schedules" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user schedules' do
        expect(json.size).to eq(10)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  #   Test suite for GET /users/:user_id/schedules/:id
  describe 'GET /users/:user_id/schedules/:id' do
    before { get "/users/#{user_id}/schedules/#{id}" }

    context 'when schedule exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the schedule' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when schedule does not exist' do
      let(:id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Schedule/)
      end
    end
  end

  #   Test suite for POST schedule
  describe 'POST post "/users/:user_id/schedules' do
    let(:valid_attributes) { { schedule: { title: 'Personal Development', user_id: user_id } } }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/schedules", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      context 'when an invalid request' do
        before { post "/users/#{user_id}/schedules", params: { schedule: { title: '' } } }

        it 'returns status code 400' do
          expect(response).to have_http_status(400)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Unable to create Schedule/)
        end
      end
    end
  end

  # Test suite for PUT schedule
  describe 'PUT /users/:user_id/schedules/:id' do
    let(:valid_attributes) { { schedule: { title: 'Meetings' } } }

    before { put "/users/#{user_id}/schedules/#{id}", params: valid_attributes }

    context 'when schedules exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the schedule' do
        updated_schedule = Schedule.find(id)
        expect(updated_schedule.title).to match(/Meetings/)
      end
    end

    context 'when the schedule does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Schedule/)
      end
    end
  end

  #   Test suite for DELETE schedule
  describe 'DELETE /users/:user_id/schedules/:id' do
    before { delete "/users/#{user_id}/schedules/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    before { get "/users/#{user_id}/schedules" }

    it 'expects size to decrease one' do
      expect(json.size).to eq(9)
    end

    it 'expects different id first one' do
      expect(json[0]['id']).not_to eq(id)
    end
  end
end

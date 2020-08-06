require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  # Initialize the test data
  let!(:schedule) { create(:schedule) }
  let!(:tasks) { create_list(:task, 20, schedule_id: schedule.id) }
  let(:schedule_id) { schedule.id }
  let(:id) { tasks.first.id }

  # Test suite for GET /schedules/:schedule_id/tasks
  describe 'GET /schedules/:schedule_id/tasks' do
    before { get "/schedules/#{schedule_id}/tasks" }

    context 'when schedule exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all schedule tasks' do
        expect(json.size).to eq(20)
      end
    end

    context 'when schedule does not exist' do
      let(:schedule_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Schedule/)
      end
    end
  end

  # Test suite for GET /schedules/:schedule_id/tasks/:id
  describe 'GET /schedules/:schedule_id/tasks/:id' do
    before { get "/schedules/#{schedule_id}/tasks/#{id}" }

    context 'when schedule task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the task' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when schedule task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for POST /schedules/:schedule_id/tasks
  describe 'POST /schedules/:schedule_id/tasks' do
    let(:valid_attributes) { { name: 'Read 2 chapters of a book', done: false } }

    context 'when request attributes are valid' do
      before { post "/schedules/#{schedule_id}/tasks", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/schedules/#{schedule_id}/tasks", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /schedules/:schedule_id/tasks/:id
  describe 'PUT /schedules/:schedule_id/tasks/:id' do
    let(:valid_attributes) { { name: 'Do a 2km run' } }

    before { put "/schedules/#{schedule_id}/tasks/#{id}", params: valid_attributes }

    context 'when task exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the task' do
        updated_task = Task.find(id)
        expect(updated_task.name).to match(/Do a 2km run/)
      end
    end

    context 'when the task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for DELETE /schedules/:id
  describe 'DELETE /schedules/:id' do
    before { delete "/schedules/#{schedule_id}/tasks/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

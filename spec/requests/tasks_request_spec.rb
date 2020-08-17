require 'rails_helper'

RSpec.describe "Tasks API", type: :request do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:schedule) { create(:schedule) }
  let!(:tasks) { create_list(:task, 10, schedule_id: schedule.id) }
  let(:user_id) { user.id }
  let(:schedule_id) { schedule.id }
  let(:id) { tasks.first.id }

  # Test suite for GET /users/:user_id/schedulees
  describe 'GET users/:user_id/schedulee/:schedule_id/tasks' do
    before { get "/users/#{user_id}/schedules/#{schedule_id}/tasks" }

    context 'when schedule exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user tasks of a certain schedule' do
        expect(json.size).to eq(10)
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

  # Test suite for GET /users/:user_id/schedules/:schedule_id/tasks/:id'
  describe 'GET /users/:user_id/schedules/:schedule_id/tasks/:id' do
    before { get "/users/#{user_id}/schedules/#{schedule_id}/tasks/#{id}" }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the task' do
        expect(json['id']).to eq(id)
      end
    end
    context 'when task does not exist' do
      let(:id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for POST tasks
  describe 'POST /users/:user_id/schedules/:schedule_id/tasks' do
    let(:valid_attributes) { { task: { name: 'New Task', date: '2019-09-15', schedule_id: schedule_id } } }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/schedules/#{schedule_id}/tasks", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/schedules/#{schedule_id}/tasks", params: { task: { done: true } } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a unable to create schedule message' do
        expect(response.body).to match(/Unable to create Task/)
      end
    end
  end

  # Test suite for PUT tasks
  describe 'PUT /users/:user_id/schedules/:schedule_id/tasks/:id' do
    let(:valid_attributes) { { task: { done: true } } }

    before { put "/users/#{user_id}/schedules/#{schedule_id}/tasks/#{id}", params: valid_attributes }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates task' do
        updated_task = Task.find(id)
        expect(updated_task.done).to match(true)
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

  #   Test suite for DELETE tasks
  describe 'DELETE /users/:user_id/schedules/:schedule_id/tasks/:id' do
    before { delete "/users/#{user_id}/schedules/#{schedule_id}/tasks/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    before { get "/users/#{user_id}/schedules/#{schedule_id}/tasks" }

    it 'expects size to decrease one' do
      expect(json.size).to eq(9)
    end

    it 'expects different id first one' do
      expect(json[0]['id']).not_to eq(id)
    end
  end
end

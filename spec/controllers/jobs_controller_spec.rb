require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  describe 'GET #index' do
    let!(:job1) { create(:job, title: 'Software Engineer', created_at: 2.days.ago) }
    let!(:job2) { create(:job, title: 'Data Scientist', created_at: 1.day.ago) }

    it 'returns a list of jobs ordered by created_at in descending order' do
      get :index

      expect(response).to have_http_status(:success)

      expect(JSON.parse(response.body)).to eq(
        [
          JobBlueprint.render_as_json(job2),
          JobBlueprint.render_as_json(job1)
        ]
      )
    end
  end
end
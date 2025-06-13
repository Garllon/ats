require 'rails_helper'

RSpec.describe ApplicationsController, type: :controller do
  describe 'GET index' do
    let!(:activated_job) { create(:job, :active) }
    let!(:deactivated_job) { create(:job) }
    let!(:application1) { create(:application, job: activated_job, created_at: 2.days.ago) }
    let!(:application2) { create(:application, job: activated_job, created_at: 1.day.ago) }
    let!(:application3) { create(:application, job: deactivated_job, created_at: 3.days.ago) }

    it 'returns a list of applications for activated jobs ordered by created_at in descending order' do
      get :index

      expect(response).to have_http_status(:success)

      expected_response = [
        ApplicationBlueprint.render_as_json(application2),
        ApplicationBlueprint.render_as_json(application1)
      ]

      expect(JSON.parse(response.body)).to eq(expected_response)
    end

    context 'when an error occurs' do
      before do
        allow(Application).to receive(:where).and_raise(StandardError.new('Something went wrong'))
      end

      it 'returns an internal server error' do
        get :index

        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Something went wrong' })
      end
    end
  end
end
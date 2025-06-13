require 'rails_helper'

RSpec.describe JobBlueprint do
  shared_examples 'rendering as JSON' do
    it 'renders the job as JSON' do
      result = described_class.render_as_json(job)
      expect(result).to include(
                          'title' => job.title,
                          'status' => job.status,
                          'hired_candiates' => hired_candidates,
                          'rejected_candidates' => rejected_candidates,
                          'interview_candidates' => interview_candidates
                        )
    end
  end

  describe '.render' do
    let(:job) { create(:job) }

    context 'without applications' do
      let(:hired_candidates) { 0 }
      let(:rejected_candidates) { 0 }
      let(:interview_candidates) { 0 }

      it_behaves_like 'rendering as JSON'
    end

    context 'with applications' do
      before do
        create(:application, :with_rejected_event, job: job)
        create(:application, :with_rejected_event, job: job)
        create(:application, :with_interview_event, job: job)
        create(:application, :with_hired_event, job: job)
      end

      let(:hired_candidates) { 1 }
      let(:rejected_candidates) { 2 }
      let(:interview_candidates) { 1 }

      it_behaves_like 'rendering as JSON'
    end
  end
end

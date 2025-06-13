require 'rails_helper'

RSpec.describe Job, type: :model do
  describe '#status' do
    shared_examples 'job status' do |event_type, expected_status|
      before do
        job.events.create!(type: event_type)
      end

      it "returns '#{expected_status}'" do
        expect(job.status).to eq(expected_status)
      end
    end

    let(:job) { create(:job) }

    it_behaves_like 'job status', 'Job::Event::Activated', 'activated'
    it_behaves_like 'job status', 'Job::Event::Deactivated', 'deactivated'

    context 'when there are more events, but the last is activated' do
      before do
        job.events.create!(type: 'Job::Event::Deactivated')
        job.events.create!(type: 'Job::Event::Activated')
      end

      it "returns activated" do
        expect(job.status).to eq('activated')
      end
    end
  end
end
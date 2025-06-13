require 'rails_helper'

RSpec.describe Application, type: :model do
  describe '#status' do
    shared_examples 'application status' do |event_type, expected_status|
      before do
        application.events.create!(type: event_type)
      end

      it "returns '#{expected_status}'" do
        expect(application.status).to eq(expected_status)
      end
    end

    let(:application) { create(:application) }

    it_behaves_like 'application status', 'Application::Event::Hired', 'hired'
    it_behaves_like 'application status', 'Application::Event::Rejected', 'rejected'
    it_behaves_like 'application status', 'Application::Event::Interview', 'interview'

    context 'when there are more events, the lat event counts' do
      before do
        application.events.create!(type: 'Application::Event::Hired')
        application.events.create!(type: 'Application::Event::Rejected')
      end

      it "returns rejected" do
        expect(application.status).to eq('rejected')
      end
    end

    context 'when the last event is a note, then the lat relavant event counts' do
      before do
        application.events.create!(type: 'Application::Event::Hired')
        application.events.create!(type: 'Application::Event::Rejected')
        application.events.create!(type: 'Application::Event::Note')
      end

      it "returns rejected" do
        expect(application.status).to eq('rejected')
      end
    end
  end
end
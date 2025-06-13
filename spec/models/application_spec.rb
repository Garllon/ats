require 'rails_helper'

RSpec.describe Application, type: :model do
  describe '#status' do
    shared_examples 'application status' do |event_type, expected_status, metadata = {}|
      before do
        Application::Event.create!(type: event_type, application:, metadata:)
      end

      it "returns '#{expected_status}'" do
        expect(application.status).to eq(expected_status)
      end
    end

    let(:application) { create(:application) }

    it_behaves_like 'application status', 'Application::Event::Hired', 'hired', { hire_date: 1.day.ago }
    it_behaves_like 'application status', 'Application::Event::Rejected', 'rejected'
    it_behaves_like 'application status', 'Application::Event::Interview', 'interview', { interview_date: 2.days.ago }

    context 'when there are more events' do
      before do
        create(:application_event_hired, application:)
        create(:application_event_rejected, application:)
      end

      context 'the last event counts' do
        it "returns rejected" do
          expect(application.status).to eq('rejected')
        end
      end

      context 'when the last event is a note, then the lat relavant event counts' do
        before do
          create(:application_event_note, application:)
        end

        it "returns rejected" do
          expect(application.status).to eq('rejected')
        end
      end
    end
  end
end
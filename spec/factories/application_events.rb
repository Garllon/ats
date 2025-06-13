FactoryBot.define do
  factory :application_event_hired, class: Application::Event::Hired do
    application { association :application }
    metadata { { hire_date: 1.day.ago } }
  end

  factory :application_event_rejected, class: Application::Event::Rejected do
    application { association :application }
    metadata { {} }
  end

  factory :application_event_interview, class: Application::Event::Interview do
    application { association :application }
    metadata { { interview_date: 2.days.ago } }
  end

  factory :application_event_note, class: Application::Event::Note do
    application { association :application }
    metadata { { content: "Some note" } }
  end
end
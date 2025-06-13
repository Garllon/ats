FactoryBot.define do
  factory :application do
    sequence(:candidate_name) { |n| "Candidate Name #{n}" }
    job { association :job }
    created_at { Time.current }
    updated_at { Time.current }

    trait :with_interview_event do
      created_at { 3.days.ago }
      updated_at { 3.days.ago }

      after(:create) do |application|
        Application::Event::Interview.create!(
          application: application,
          metadata: { interview_date: 2.days.ago },
          created_at: 2.days.ago
        )
      end
    end

    trait :with_rejected_event do
      created_at { 3.days.ago }
      updated_at { 3.days.ago }

      after(:create) do |application|
        Application::Event::Rejected.create!(
          application: application,
          created_at: 2.days.ago
        )
      end
    end

    trait :with_hired_event do
      created_at { 3.days.ago }
      updated_at { 3.days.ago }

      after(:create) do |application|
        Application::Event::Hired.create!(
          application: application,
          metadata: { hire_date: 1.day.ago },
          created_at: 2.days.ago
        )
      end
    end
  end
end
FactoryBot.define do
  factory :job do
    sequence(:title) { |n| "Job Title #{n}" }
    description { "This is a sample job description." }
    created_at { Time.current }
    updated_at { Time.current }

    trait :active do
      after(:create) do |job|
        job.events.create!(type: 'Job::Event::Activated')
      end
    end
  end
end
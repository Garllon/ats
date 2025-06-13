FactoryBot.define do
  factory :job do
    sequence(:title) { |n| "Job Title #{n}" }
    description { "This is a sample job description." }
    created_at { Time.current }
    updated_at { Time.current }
  end
end
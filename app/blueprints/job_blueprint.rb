class JobBlueprint < Blueprinter::Base
  fields :title, :status

  field :hired_candiates do |job|
    job.applications.select { |application| %w[hired].include?(application.status) }.count
  end

  field :rejected_candidates do |job|
    job.applications.select { |application| %w[rejected].include?(application.status) }.count
  end

  field :interview_candidates do |job|
    job.applications.select { |application| %w[applied interview].include?(application.status) }.count
  end
end
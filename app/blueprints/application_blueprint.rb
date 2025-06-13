class ApplicationBlueprint < Blueprinter::Base

  field :job do |application|
    application.job.title
  end
  fields :candidate_name, :status

  field :notes do |application|
    application.events.select { |event| event.is_a?(Application::Event::Note) }
                      .count { |note| note.content }
  end

  field :interview_date do |application|
    interview_event = application
                        .events
                        .order(created_at: :desc)
                        .find { |event| event.is_a?(Application::Event::Interview) }

    interview_event.nil? ? nil : interview_event.interview_date
  end
end
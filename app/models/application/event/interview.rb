class Application::Event::Interview < Application::Event
  include HasMetadata
  metadata_keys :interview_date
end

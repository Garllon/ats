class Application::Event::Hired < Application::Event
  include HasMetadata
  metadata_keys :hired_date
end

class Application::Event::Hired < Application::Event
  include HasMetadata
  metadata_keys :hire_date
end

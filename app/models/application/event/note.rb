class Application::Event::Note < Application::Event
  include HasMetadata
  metadata_keys :content
end

class Application::Event < ApplicationRecord
  belongs_to :application

  before_validation :ensure_metadata

  private

  def ensure_metadata
    self.metadata ||= {}
  end
end

class Application < ApplicationRecord
  has_many :events, class_name: 'Application::Event', dependent: :destroy
  belongs_to :job

  def status
    last_event = events.where.not(type: 'Application::Event::Note').order(created_at: :desc).first

    case last_event
    when nil
      'applied'
    when Application::Event::Interview
      'interview'
    when Application::Event::Hired
      'hired'
    when Application::Event::Rejected
      'rejected'
    end
  end
end

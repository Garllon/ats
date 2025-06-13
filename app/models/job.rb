class Job < ApplicationRecord
  has_many :events, class_name: 'Job::Event', dependent: :destroy
  has_many :applications, dependent: :destroy

  def status
    last_event = events.order(created_at: :desc).first

    case last_event
    when Job::Event::Activated
      'activated'
    when Job::Event::Deactivated, nil
      'deactivated'
    end
  end
end


class JobsController < ApplicationController
  def index
    jobs = Job.all.order(created_at: :desc)

    render json: JobBlueprint.render_as_json(jobs)
  end
end
class ApplicationsController < ActionController::API
  def index
    activated_job_ids = Job.all.select { |job| job.status == 'activated' }.map(&:id)
    applications = Application.where(job_id: activated_job_ids).order(created_at: :desc)

    render json: ApplicationBlueprint.render_as_json(applications)
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end

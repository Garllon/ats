# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def create_activated_jobs
  puts 'Creating Activated Jobs'

  raw_jobs = [
    { title: 'Software Engineer',
      description: 'We are looking for a skilled software engineer to join our team.' \
        'The ideal candidate will have experience in Ruby on Rails and a passion' \
        'for building scalable applications.' },
    { title: 'Product Manager',
      description: 'We are seeking a product manager to lead our product development team.' \
        'The ideal candidate will have experience in Agile methodologies and a' \
        'strong understanding of user experience.' },
    { title: 'Data Scientist',
      description: 'We are looking for a data scientist to analyze large datasets and provide' \
        'insights to drive business decisions. The ideal candidate will have experience' \
        'in machine learning and statistical analysis.' }]

  raw_jobs.each do |raw_job|
    job = Job.find_or_create_by!(title: raw_job[:title]) do |j|
      j.description = raw_job[:description]
    end

    Job::Event::Activated.create!(
      job: job,
      created_at: 3.days.ago
    )
  end

  puts 'Jobs created successfully!'
end

def create_applications_for_software_engineer
  job = Job.find_by(title: 'Software Engineer')

  # Applicatant 1
  applicant_1 = Application.create!(
    job: job,
    candidate_name: "Darth Vader")

  Application::Event::Interview.create!(
    application: applicant_1,
    metadata: {
      interview_date: 2.days.ago },
    created_at: 2.days.ago
  )
  Application::Event::Hired.create!(application: applicant_1,
                                    metadata: { hire_date: 1.day.ago },
                                    created_at: 1.day.ago)

  # Applicant 2
  applicant_2 = Application.create!(
    job: job,
    candidate_name: "Master Yoda")

  Application::Event::Rejected.create!(
    application: applicant_2,
    created_at: 2.days.ago
  )

  # Applicant 3
  applicant_3 = Application.create!(
    job: job,
    candidate_name: "Grogu")

  Application::Event::Note.create!(
    application: applicant_3,
    metadata: {
      content: "Good potential, consider for another role."
    })

  job.events.create!(type: 'Job::Event::Deactivated')
end

Job::Event.delete_all
Application::Event.delete_all
Application.delete_all
Job.delete_all

create_activated_jobs
create_applications_for_software_engineer
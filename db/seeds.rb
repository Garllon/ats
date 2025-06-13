# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'create Jobs'
jobs = [
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

jobs.each do |job|
  Job.find_or_create_by!(title: job[:title]) do |j|
    j.description = job[:description]
  end
end

puts 'Jobs created successfully!'
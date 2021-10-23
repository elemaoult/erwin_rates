# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Freelancer.all.each do |f|
    f.destroy unless f.source.seed_valid?
end

puts 'Parsing time, please wait...'
sources_seed = Source.create!(
    date: Time.now,
    data_source: ("Faker"),
    seed_valid: false
)

# Freelancer.from_seed.destroy_all


puts 'Done!'

puts 'Creating 50 fake persons...'
50.times do
  $freelancers_feeding = Freelancer.create!(
    first_name:     Faker::Name.first_name,
    last_name:      Faker::Name.last_name,
    location:       Faker::Address.city,
    job_description: Faker::Job.title,
    mission_duration_sought: Faker::Job.employment_type,
    experience:     Faker::Job.seniority,
    nb_of_previous_mission: rand(10..99),
    rating:         rand(1..5),
    remote:         [true, false].sample,
    daily_rate:     rand(300..900),
    currency:       ["EUR", "USD", "GBP", "SEK", "CHF", "DKK"].sample,
    source_id:      sources_seed.id
  )
end
puts 'Done!'

puts 'Database strengthen processes...'
expertises_feeding = Expertise.create!(
    name:           Faker::Job.field
    )

industries_feeding = Industry.create!(
    name:           Faker::IndustrySegments.sector
)

technologies_feeding = Technology.create(
    name:           Faker::Computer.stack
)

persons_exp_feeding = FreelancerExpertise.create(
    freelancer_id: $freelancers_feeding.id,
    expertise_id: expertises_feeding.id
)

persons_ind_feeding = FreelancerIndustry.create(
    freelancer_id: $freelancers_feeding.id,
    industry_id: industries_feeding.id
)

persons_tec_feeding = FreelancerTechnology.create(
    freelancer_id: $freelancers_feeding.id,
    technology_id: technologies_feeding.id
)
puts 'Success!'

#   freelancers = Freelancer.all.sample
#   freelancers.save!

puts 'Finished! Enjoy your data(TM)!'
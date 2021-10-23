# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Parsing time, please wait...'
origin_seed = Origin.create(
    date: Time.now,
    data_origin: ("Faker"),
    seed_valid: false
)

if People.origin.seed_valid = false
    People.destroy
end
puts 'Done!'

puts 'Creating 50 fake persons...'
50.times do
  persons_feeding = People.create(
    first_name:     Faker::Name.first_name,
    last_name:      Faker::Name.last_name,
    location:       Faker::Address.city,
    job_desciption: Faker::Job.title,
    mission_duration_sought: Faker::Job.employment_type,
    experience:     Faker::Job.seniority,
    nb_of_previous_mission: rand(10..99),
    rating:         rand(1..5),
    remote:         [true, false].sample,
    daily_rate:     rand(300..900),
    currency:       ["EUR", "USD", "GBP", "SEK", "CHF", "DKK"].sample,
    origin_id:      origin_seed.id
  )
end
puts 'Done!'

puts 'Database strengthen processes...'
expertises_feeding = Expertises.create(
    name:           Faker::Job.field,
    category:       Faker::Job.position
)

industries_feeding = Industries.create(
    name:           Faker::IndustrySegments.sector
)

technologies_feeding = Technologies.create(
    name:           Faker::Computer.stack
)

persons_exp_feeding = Persons_Expertise.create(
    person_id: persons_feeding.id,
    expertise_id: expertises_feeding.id
)

persons_ind_feeding = Persons_industries.create(
    person_id: persons_feeding.id,
    industry_id: industries_feeding.id
)

persons_tec_feeding = Persons_technologies.create(
    person_id: persons_feeding.id,
    technology_id: technologies_feeding.id
)
puts 'Success!'

  persons = Persons.all.sample
  persons.save!

puts 'Finished! Enjoy your data(TM)!'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'nokogiri'
require 'pry-byebug'

# Freelancer.all.each do |f|
#     f.destroy unless f.source.seed_valid?
# end

# puts 'Parsing time, please wait...'
# sources_seed = Source.create!(
#     date: Time.now,
#     data_source: ("Malt"),
#     seed_valid: true
# )

# Scraping script
url = '../public/page1_back_senior.html'
file = File.open(url)
doc = Nokogiri::HTML(file)

tech_array = []

doc.search('.freelance-linkable').each do |element|
  seniority = "Senior"
  expertise = "Backend"
  first_name = element.search('.profile-card-header__full-name').text.strip.gsub(/\s\w+/,'')
  location = element.search('.c-tooltip_target').first.text.strip.gsub(/Localisé\(e\) à /, '')
  day_rate = element.search('.profile-card-price__rate').text.strip.gsub(/€\/jour/, '').to_i
  job_title = element.search('.profile-card-body__header').text.strip
  remote_base = element.css('.c-tooltip')[0].attributes.select{|h| h["data-js"]}["data-js"].value
    if remote_base.include? "distance"
      remote = true
    else
      remote = false
    end
  technologies = element.search('.m-tag_small').each do |technology|
    tech_array << technology.text.strip
  end
  binding.pry

  puts 'Done!'

  puts 'Creating Freelancer'
    $freelancers_feeding = Freelancer.create!(
      first_name:     first_name,
      last_name:      "Anonymous",
      location:       location,
      job_description: job_title,
      # mission_duration_sought: 10, #Not now
      experience:     seniority,
      # nb_of_previous_mission: 10, #Not now
      # rating:         5, #Not now
      remote:         remote,
      daily_rate:     day_rate,
      currency:       "EUR",
      source_id:      sources_seed.id
    )
  puts 'Done!'

  puts 'Database strengthen processes...'
  expertises_feeding = Expertise.create!(
      name:           expertise
      )

  # industries_feeding = Industry.create!(
  #     name:           Faker::IndustrySegments.sector #To check
  # )

  technologies_feeding = Technology.create(
      name:           tech_array #To check how to play with the array
  )

  persons_exp_feeding = FreelancerExpertise.create(
      freelancer_id: $freelancers_feeding.id,
      expertise_id: expertises_feeding.id
  )

  # persons_ind_feeding = FreelancerIndustry.create(
  #     freelancer_id: $freelancers_feeding.id,
  #     industry_id: industries_feeding.id
  # )

  persons_tec_feeding = FreelancerTechnology.create(
      freelancer_id: $freelancers_feeding.id,
      technology_id: technologies_feeding.id
  )
  puts 'Success!'
end

puts 'Finished! Enjoy your data(TM)!'


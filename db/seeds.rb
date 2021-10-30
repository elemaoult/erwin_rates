# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'

Freelancer.all.each do |f|
    f.destroy unless f.source.seed_valid?
end

puts 'Parsing time, please wait...'
sources_seed = Source.create!(
    date: Time.now,
    data_source: ("Malt"),
    seed_valid: true
)

my_array = ['../public/Backend_intermediaire_page1.html', '../public/Backend_intermediaire_page2.html', '../public/Backend_intermediaire_page3.html', '../public/Backend_intermediaire_page4.html', '../public/Backend_intermediaire_page5.html',
        '../public/Backend_intermediaire_page6.html', '../public/Backend_intermediaire_page7.html', '../public/Backend_intermediaire_page8.html', '../public/Backend_intermediaire_page9.html', '../public/Backend_intermediaire_page10.html',
        '../public/Backend_intermediaire_page11.html', '../public/Backend_intermediaire_page12.html', '../public/Backend_intermediaire_page13.html', '../public/Backend_intermediaire_page14.html', '../public/Backend_intermediaire_page15.html', 
        '../public/Backend_intermediaire_page16.html', '../public/Backend_intermediaire_page17.html', '../public/Backend_intermediaire_page18.html', '../public/Backend_intermediaire_page19.html', '../public/Backend_intermediaire_page20.html', '../public/Backend_intermediaire_page21.html']

my_array.each do |my_url|
# Scraping script
    url = File.join(File.dirname(__FILE__), my_url)
    file = File.open(url)
    doc = Nokogiri::HTML(file)

    tech_array = []

    doc.search('.freelance-linkable').each do |element|
    seniority = "Intermédiaire"
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
    tech_array.each do |technology|
        techno = Technology.find_by(name: technology)
        if techno
            persons_tech_feeding = FreelancerTechnology.create(
                freelancer_id: $freelancers_feeding.id,
                technology_id: techno.id
            )
        else 
            techno = Technology.new(
                name:           technology #To check how to play with the array
            )
            techno.save!
            persons_tech_feeding = FreelancerTechnology.create(
                freelancer_id: $freelancers_feeding.id,
                technology_id: techno.id
            )
        end
    end

    exp = Expertise.find_by(name: expertise)
    if exp
    persons_exp_feeding = FreelancerExpertise.create(
        freelancer_id: $freelancers_feeding.id,
        expertise_id: expertises_feeding.id
    )
    else
    expertises_feeding = Expertise.create!(
        name:           expertise
    )
    persons_exp_feeding = FreelancerExpertise.create(
        freelancer_id: $freelancers_feeding.id,
        expertise_id: expertises_feeding.id
    )
    end

    # persons_ind_feeding = FreelancerIndustry.create(
    #     freelancer_id: $freelancers_feeding.id,
    #     industry_id: industries_feeding.id
    # )

    puts 'Success!'
    end
    puts 'Page Done!'
end
#   freelancers = Freelancer.all.sample
#   freelancers.save!

puts 'Finished! Enjoy your data(TM)!'


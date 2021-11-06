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
# DO THE FUCKING ARRAY

my_array = ['../public/page1_front_senior.html', '../public/page2_front_senior.html', '../public/page3_front_senior.html', '../public/page4_front_senior.html', '../public/page5_front_senior.html', '../public/page6_front_senior.html', 
    '../public/page7_front_senior.html', '../public/page8_front_senior.html', '../public/page9_front_senior.html', '../public/page10_front_senior.html', '../public/page11_front_senior.html', '../public/page12_front_senior.html',
    '../public/page13_front_senior.html', '../public/page14_front_senior.html', '../public/page15_front_senior.html', '../public/page16_front_senior.html', '../public/page17_front_senior.html',
    '../public/page1_back_senior.html','../public/page2_back_senior.html', '../public/page8_back_senior.html','../public/page9_back_senior.html','../public/page10_back_senior.html','../public/page11_back_senior.html','../public/page12_back_senior.html',
    '../public/page13_back_senior.html','../public/page14_back_senior.html','../public/page15_back_senior.html','../public/page16_back_senior.html','../public/page17_back_senior.html','../public/page18_back_senior.html', '../public/page1_cloud_junior.html', '../public/page1_cloud_intermediate.html',
    '../public/page1_cloud_senior.html', '../public/page2_cloud_intermediate.html', '../public/page2_cloud_senior.html', '../public/page3_cloud_intermediate.html', '../public/page3_cloud_senior.html', '../public/page4_cloud_intermediate.html', '../public/page4_cloud_senior.html',
    '../public/Backend_intermediaire_page1.html', '../public/Backend_intermediaire_page2.html', '../public/Backend_intermediaire_page3.html', '../public/Backend_intermediaire_page4.html', '../public/Backend_intermediaire_page5.html', '../public/Backend_intermediaire_page6.html',
    '../public/Backend_intermediaire_page7.html', '../public/Backend_intermediaire_page8.html', '../public/Backend_intermediaire_page9.html', '../public/Backend_intermediaire_page10.html', '../public/Backend_intermediaire_page11.html', '../public/Backend_intermediaire_page12.html',
    '../public/Backend_intermediaire_page13.html', '../public/Backend_intermediaire_page14.html', '../public/Backend_intermediaire_page15.html', '../public/Backend_intermediaire_page16.html', '../public/Backend_intermediaire_page17.html', '../public/Backend_intermediaire_page18.html',
    '../public/Backend_intermediaire_page19.html', '../public/Backend_intermediaire_page20.html', '../public/Backend_intermediaire_page21.html','../public/Fronted_intermédiaire_page1.html','../public/Fronted_intermédiaire_page2.html','../public/Fronted_intermédiaire_page3.html',
    '../public/Fronted_intermédiaire_page4.html','../public/Fronted_intermédiaire_page5.html','../public/Fronted_intermédiaire_page6.html','../public/Fronted_intermédiaire_page7.html','../public/Fronted_intermédiaire_page8.html','../public/Fronted_intermédiaire_page9.html',
    '../public/Fronted_intermédiaire_page10.html','../public/Fronted_intermédiaire_page11.html','../public/Fronted_intermédiaire_page12.html','../public/Fronted_intermédiaire_page13.html','../public/Fronted_intermédiaire_page14.html','../public/Fronted_intermédiaire_page15.html',
    '../public/Fronted_intermédiaire_page16.html','../public/Fronted_intermédiaire_page17.html','../public/Fronted_intermédiaire_page18.html','../public/Fronted_intermédiaire_page19.html','../public/Fronted_intermédiaire_page20.html','../public/Fronted_intermédiaire_page21.html',
    '../public/Fronted_intermédiaire_page22.html','../public/Fronted_intermédiaire_page23.html','../public/Fronted_intermédiaire_page24.html','../public/page1_design_intermediaire.html', '../public/page2_design_intermediaire.html', '../public/page3_design_intermediaire.html',
    '../public/page4_design_intermediaire.html', '../public/page5_design_intermediaire.html', '../public/page6_design_intermediaire.html', '../public/page7_design_intermediaire.html', '../public/page8_design_intermediaire.html', '../public/page9_design_intermediaire.html',
    '../public/page10_design_intermediaire.html', '../public/page11_design_intermediaire.html', '../public/page1_design_junior.html', '../public/page2_design_junior.html', '../public/page3_design_junior.html', '../public/page1_design_senior.html', '../public/page2_design_senior.html',
    '../public/page2_design_senior.html', '../public/page3_design_senior.html', '../public/page4_design_senior.html', '../public/page5_design_senior.html', '../public/page6_design_senior.html', '../public/page7_design_senior.html', '../public/page8_design_senior.html',
    '../public/page1_back_junior.html', '../public/page1_back_junior.html', '../public/page3_back_junior.html', '../public/page4_back_junior.html',  '../public/page5_back_junior.html', '../public/page6_back_junior.html', '../public/page7_back_junior.html', '../public/page8_back_junior.html']

my_array.each do |my_url|
# Scraping script
    url = File.join(File.dirname(__FILE__), my_url)
    file = File.open(url)
    doc = Nokogiri::HTML(file)

    tech_array = []

    doc.search('.freelance-linkable').each do |element|
        # Seniority
        if url.include?("intermediate" || "intermédiaire" || "intermediaire") 
            seniority = "Intermédiaire"
        elsif url.include?("senior")
            seniority = "Senior"
        else
            seniority = "Junior"
        end

        # Expertise
        if url.include?("cloud") 
            expertise = "DevOps / Cloud"
        elsif url.include?("design")
            expertise = "UX/UI Designer"
        elsif url.include?("Fronted" || "front")
            expertise = "Frontend"
        else
            expertise = "Backend"
        end

        # First name
        first_name = element.search('.profile-card-header__full-name').text.strip.gsub(/\s\w+/,'')
        # Location (town)
        location = element.search('.c-tooltip_target').first.text.strip.gsub(/Localisé\(e\) à /, '')
        # Day Rate
        day_rate = element.search('.profile-card-price__rate').text.strip.gsub(/€\/jour/, '').to_i
        # Job Title
        job_title = element.search('.profile-card-body__header').text.strip
        # Remote (True / False)
        remote_base = element.css('.c-tooltip')[0].attributes.select{|h| h["data-js"]}["data-js"].value
            if remote_base.include? "distance"
            remote = true
            else
            remote = false
            end
        # Technologies of the freelancer (in array)
        technologies = element.search('.m-tag_small').each do |technology|
            tech_array << technology.text.strip
        end

        # puts 'Done!'

        free = Freelancer.find_by(first_name: first_name, job_description: job_title)
        if free
            break
            # puts "free already exists"
        else
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
            # puts 'Done!'

            # puts 'Database strengthen processes...'

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
                expertise_id: exp.id
            )
            else
            exp = Expertise.create!(
                name:           expertise
            )
            persons_exp_feeding = FreelancerExpertise.create(
                freelancer_id: $freelancers_feeding.id,
                expertise_id: exp.id
            )
            end
            # puts 'Success!'
        end

    end
    # puts 'Page Done!'
end

# def add_daily_rate_interval_to_data
#     Freelancer.all.each do |freelancer|
#       freelancer.daily_rate_interval = freelancer.daily_rate.div(50)
#     end
# end

puts 'Finished! Enjoy your data(TM)!'

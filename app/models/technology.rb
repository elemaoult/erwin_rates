class Technology < ApplicationRecord
  require 'csv'

  has_many :freelancer_technologies, dependent: :destroy
  has_many :freelancers, through: :freelancer_technologies


  def self.parsing_technology_data
    filepath = 'app/models/technology_name.csv'
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }

    CSV.foreach(filepath, csv_options) do |row|
      if !Technology.where(name: row['technology'].upcase.strip).blank?
        Technology.where(name: row['technology'].upcase).each do |technology|
          row['tech_group'].blank? ? technology.inserted_in_analysis = false : technology.inserted_in_analysis = row['is_display']
          technology.group_name = row['tech_group'].strip
          technology.save
        end
      end
    end

  end

end
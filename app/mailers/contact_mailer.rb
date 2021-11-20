class ContactMailer < ApplicationMailer
    def notify(contact_hash)
      mail(to:contact_hash[:email], subject: contact_hash[:subject]) 
    end
end

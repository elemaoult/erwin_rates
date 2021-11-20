# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
    def notify
        # This is how you pass value to params[:user] inside mailer definition!
        contact_infos = {
            name: 'emilie', 
            email: 'em.lemaoult@gmail.com',
            subject: 'hello',
            message: 'yoooo'
          }
        ContactMailer.notify(contact_infos)
    end
end

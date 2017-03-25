class ContactMailer < ActionMailer::Base
    default to: 'mltghr@googlemail.com'
    
    def contact-email(name, email, body)
       @name = name
       @email = email
       @body = body
       
       mail(from: email, subject: 'Contact Form Message')
    end
end
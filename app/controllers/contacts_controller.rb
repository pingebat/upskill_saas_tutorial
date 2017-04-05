class ContactsController < ApplicationController
  
  #GET Request to /contact-us
  #Show new contact form
  def new
    @contact = Contact.new
  end
  
  # POST request /contacts
    def create
      #Mass asignmenr of form fields into contact object
      @contact = Contact.new(contact_params)
      if @contact.save
        #Save the Contact object to th database
        #Store form fields via paramenters into the variables
        name = params[:contact][:name]
        email = params[:contact][:email]
        body = params[:contact][:comments]
        #plug variables into the contact mailer email method and send email
        ContactMailer.contact_email(name, email, body).deliver
        # Store succses message in flash hash
        #and redirect to the new action
        flash[:success] = "Message sent"
          redirect_to new_contact_path
      else
        #if Contact object does not save
        #store errors in flash hash
        #and redirect to the new action
        flash[:danger] = @contact.errors.full_messages.join(", ")
        redirect_to new_contact_path
      end
    end
   
    private
    #to collect data from form we need to use
    #strong parameters and white list form fields
      def contact_params
        params.require(:contact).permit(:name, :email, :comments)
      end
  
end
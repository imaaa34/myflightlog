class ContactMailer < ApplicationMailer
  default from: "admin@admin.com"

  def received_email(contact)
    @contact = contact
    mail(:to => contact.mail, :subject => 'お問い合わせがありました。')
  end

end

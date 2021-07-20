class ContactMailer < ApplicationMailer
  def send_email(contact)
    @contact = contact
    mail(
      to: ENV['NAME'],
      subject: @contact.name + '様からお問い合わせがありました'
    )
  end
end

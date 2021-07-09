class ContactMailer < ApplicationMailer

  def send_email(contact)
    @contact = contact
    mail(
      from: contact.email,
      to: 'admin@gmail.com',
      subject: @contact.name + '様からお問い合わせがありました。'
    )
  end

end

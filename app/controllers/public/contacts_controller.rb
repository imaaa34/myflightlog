class Public::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.send_email(@contact).deliver
      redirect_to complete_contact_path
    else
      flash.now[:alert] = '送信できませんでした。'
      render :new
    end
  end

  def complete
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :content)
    end

end

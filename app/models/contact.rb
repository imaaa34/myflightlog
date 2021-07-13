class Contact < ApplicationRecord

  include ActiveModel::Model

  attr_accessor :name, :email, :content

  validates :name, presence: true
  validates :email, presence: true
  validates :content, presence: true

end

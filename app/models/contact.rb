class Contact < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :content, presence: true, length: { maximum: 300 }
end

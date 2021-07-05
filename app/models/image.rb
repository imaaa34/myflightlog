class Image < ApplicationRecord

  belongs_to :log
  attachment :image

end

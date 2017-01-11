class Restaurant < ApplicationRecord
  mount_uploader :cover_photo, CoverPhotoUploader

  # Direct associations

  has_many   :restaurant_tags,
             :dependent => :destroy

  has_many   :reviews,
             :dependent => :destroy

  # Indirect associations

  has_many   :tags,
             :through => :restaurant_tags,
             :source => :tag

  # Validations

end

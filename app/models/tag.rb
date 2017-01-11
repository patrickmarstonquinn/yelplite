class Tag < ApplicationRecord
  # Direct associations

  has_many   :restaurant_tags,
             :dependent => :destroy

  # Indirect associations

  # Validations

end

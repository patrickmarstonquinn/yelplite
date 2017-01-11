class Tag < ApplicationRecord
  # Direct associations

  has_many   :restaurant_tags,
             :dependent => :destroy

  # Indirect associations

  has_many   :restaurants,
             :through => :restaurant_tags,
             :source => :restaurant

  # Validations

end

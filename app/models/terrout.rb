class Terrout < ApplicationRecord
  validates_presence_of :terrid, :publisher, :dateout
  validates_uniqueness_of :terrid
end

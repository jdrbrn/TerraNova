class Terrout < ApplicationRecord
  validates_presence_of :terrid, :publisher, :dateout
  #Validates that the terrid is not shared as a territory can not be checked out
  #to multiple people
  validates_uniqueness_of :terrid
end

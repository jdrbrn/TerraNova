class Terrin < ApplicationRecord
  validates_presence_of :terrid
  #Validates that the terrid is not shared as a territory can not be checked in
  #multiple times at once
  validates_uniqueness_of :terrid
end

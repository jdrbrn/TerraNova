class Terrout < ApplicationRecord
  validates_presence_of :terrid
  validates_uniqueness_of :terrid
end

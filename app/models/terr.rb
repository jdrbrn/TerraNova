class Terr < ApplicationRecord
  serialize :history, Array
  validates_uniqueness_of :name
  validates_presence_of :name, :region
end

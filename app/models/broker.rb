class Broker < ApplicationRecord
  validates_uniqueness_of :name
end

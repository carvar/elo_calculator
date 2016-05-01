class Tournament < ActiveRecord::Base
  has_many :entries
  has_many :players, through: :entries
end

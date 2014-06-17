class Actor < ActiveRecord::Base
  has_many :characters
  has_many :television_shows, through: :characters

  validates :name, presence: true, uniqueness: true
end

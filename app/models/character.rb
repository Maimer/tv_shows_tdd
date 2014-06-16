class Character < ActiveRecord::Base
  validates :name, :character, presence: true,
  uniqueness: { scope: :television_show_id }
end

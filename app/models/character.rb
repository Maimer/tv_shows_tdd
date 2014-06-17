class Character < ActiveRecord::Base
  belongs_to :television_show
  belongs_to :actor

  validates :name, presence: true, uniqueness: { scope: :television_show_id }
  validates :actor, presence: true
end

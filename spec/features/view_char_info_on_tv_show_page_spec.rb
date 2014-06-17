require 'rails_helper'

feature 'view character info on tv show page', %Q{
  As a site visitor
  I want to view the details for a TV show
  So I can learn more about it
} do

# Acceptance Criteria:
# * I can see a the show's title, network, the years it ran, and a synopsis
# * For each character, I can see the character's name, actor's name, and the character's description

  scenario 'user views tv show page' do
    tv_attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.create(tv_attrs)

    actors = []
    actor_attrs = [
      { name: 'Kit Harrington' },
      { name: 'Sean Bean' }
    ]

    actor_attrs.each do |attrs|
      actor = Actor.new(attrs)
      actor.save
      actors << actor
    end

    characters = []
    character_attrs = [
      { name: 'Jon Snow', actor: actors[0], description: 'Knows nothing' },
      { name: 'Ned Stark', actor: actors[1], description: 'Dead' }
    ]

    character_attrs.each do |attrs|
      char = Character.new(attrs)
      char.television_show_id = show.id
      char.save
      characters << char
    end

    visit "/television_shows/#{show.id}"
    expect(page).to have_content show.title
    expect(page).to have_content show.network
    expect(page).to have_content show.years
    expect(page).to have_content show.synopsis
    characters.each do |char|
      expect(page).to have_content char.name
      expect(page).to have_content char.actor.name
      expect(page).to have_content char.description
    end
  end
end

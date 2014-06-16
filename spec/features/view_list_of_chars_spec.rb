require 'rails_helper'

feature 'view a list of characters', %Q{
  As a site visitor
  I want to view a list of people's favorite TV characters
  So I can find wonky characters to watch
} do

#   Acceptance Criteria:
# * I can see a list of all the characters
# * The character's name and the TV show it is associated with are listed

  scenario 'user views Characters' do
    shows = []
    show_attrs = [
      { title: 'Game of Thrones', network: 'HBO' },
      { title: 'Fargo', network: 'FX' }
    ]

    characters = []
    got_character_attrs = [
      { name: 'Jon Snow', actor: 'Kit Harrington', description: 'Knows nothing' },
      { name: 'Ned Stark', actor: 'Sean Bean', description: 'Dead' }
    ]
    fargo_character_attrs = [
      { name: 'Lester Nygaard', actor: 'Martin Freeman', description: 'Doncha know' },
      { name: 'Lorne Malvo', actor: 'Billy Bob Thorton', description: 'Is this waht you want?' }
    ]

    show_attrs.each do |attrs|
      shows << TelevisionShow.create(attrs)
    end

    got_character_attrs.each do |attrs|
      char = Character.new(attrs)
      char.television_show_id = shows[0].id
      char.save
      characters << char
    end

    fargo_character_attrs.each do |attrs|
      char = Character.new(attrs)
      char.television_show_id = shows[1].id
      char.save
      characters << char
    end

    visit '/characters'
    characters.each do |char|
      expect(page).to have_content char.name
      expect(page).to have_content char.television_show.title
    end
  end
end









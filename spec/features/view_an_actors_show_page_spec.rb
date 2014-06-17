require 'rails_helper'

feature 'view an actor show page', %Q{
  As a site visitor
  I want to view the details for an actor
  So I can learn more about him/her
} do

  scenario 'user views tv show page' do
    show = TelevisionShow.create(title: 'Game of Thrones', network: 'HBO')
    show2 = TelevisionShow.create(title: 'Pick Anything', network: 'Meathead')
    actor = Actor.create(name: 'Kit Harrington')
    character = Character.create(name: 'Jon Snow', actor: actor, description: 'Knows nothing', television_show_id: show.id)
    character2 = Character.create(name: 'Big Man', actor: actor, description: 'Know everything', television_show_id: show2.id)

    visit "/actors/#{actor.id}"

    expect(page).to have_content actor.name
    actor.characters.each do |char|
      expect(page).to have_content char.name
      expect(page).to have_content char.television_show.title
    end
  end
end

require 'rails_helper'

feature 'user adds a new TV show character', %Q{
  As a site visitor
  I want to add my favorite TV show characters
  So that other people can enjoy their crazy antics
} do

#   Acceptance Criteria:
# * I can access a form to add a character on a TV show's page
# * I must specify the character's name and the actor's name
# * I can optionally provide a description
# * If I do not provide the required information, I receive an error message
# * If the character already exists in the database, I receive an error message

  scenario 'user adds a new TV show character' do
    tv_attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.create(tv_attrs)

    actor_attrs = {
      name: 'Kit Harrington'
    }

    actor = Actor.create(actor_attrs)

    attrs = {
      name: 'Jon Snow',
      actor: actor,
      description: 'Knows nothing'
    }

    character = Character.new(attrs)

    visit "/television_shows/#{show.id}"
    fill_in 'Name', with: character.name
    fill_in 'Actor', with: actor.name
    fill_in 'Description', with: character.description
    click_on 'Submit'

    expect(page).to have_content 'Success'
    expect(page).to have_content character.name
    expect(page).to have_content character.actor.name
    expect(page).to have_content character.description
  end

  scenario 'without required attributes' do
    tv_attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.create(tv_attrs)

    attrs = {
      name: 'Jon Snow',
      actor: 'Kit Harrington',
      description: 'Knows nothing'
    }

    character = Character.new(attrs)

    visit "/television_shows/#{show.id}"
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "can't be blank"
  end

  scenario 'user cannot add a character that is already in the database' do
    tv_attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.create(tv_attrs)

    attrs = {
      name: 'Jon Snow',
      actor: 'Kit Harrington',
      description: 'Knows nothing'
    }

    character1 = Character.new(attrs)
    character1.television_show_id = show.id
    character1.save

    character = Character.new(attrs)

    visit "/television_shows/#{show.id}"
    fill_in 'Name', with: character.name
    fill_in 'Actor', with: character.actor
    fill_in 'Description', with: character.description
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "has already been taken"
  end
end













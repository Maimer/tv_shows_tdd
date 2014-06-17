require 'rails_helper'

feature 'user adds a new actor', %Q{
  As a site visitor
  I want to add my favorite actor
  So that other people can enjoy their crazy antics
} do

#   Acceptance Criteria:
# * I can access a form to add a actor on a TV show's page
# * I must specify the actor's name
# * I can optionally provide a description
# * If I do not provide the required information, I receive an error message
# * If the actor already exists in the database, I receive an error message

  scenario 'user adds a new actor' do
    attrs = {
      name: 'Kit Harrington'
    }

    actor = Actor.new(attrs)

    visit "/actors"
    fill_in 'Name', with: actor.name
    click_on 'Submit'

    expect(page).to have_content 'Success'
    expect(page).to have_content actor.name
  end
end

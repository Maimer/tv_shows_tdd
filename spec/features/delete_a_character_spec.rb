require 'rails_helper'

feature 'delete a character', %Q{
  As a site visitor
  I want to delete a character I don't like
  So no one else will want to watch that character
} do

# Acceptance Criteria:
# * I can delete a character from the database
# * If the record is not successfully deleted, I receive an error message

  scenario 'delete a character' do
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
    click_on 'Remove'

    expect(page).to have_content 'Success, Character Deleted!'
    expect(page).to_not have_content 'Jon Snow'
  end
end

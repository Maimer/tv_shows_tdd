require 'rails_helper'

feature 'user views an actor index page', %Q{
  As a site visitor
  I want to view my favorite actors
  So that other people can enjoy their crazy antics
} do

  scenario 'user views an actor index page' do
    actors = []
    actor_attrs = [
      { name: 'Kit Harrington' },
      { name: 'Sean Bean' },
      { name: 'Martin Freeman'},
      { name: 'Billy Bob Thorton'}
    ]

    actor_attrs.each do |attrs|
      actors << Actor.create(attrs)
    end

    visit '/actors'
    actors.each do |actor|
      expect(page).to have_content actor.name
    end
  end
end

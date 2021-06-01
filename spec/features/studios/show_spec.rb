require 'rails_helper'

RSpec.describe 'Studio show page' do
  before(:each) do
    @studio_1 = Studio.create!(name: "Universal Studios", location: "Hollywood")
    @movie_1 = @studio_1.movies.create!(title: "Raiders of the Lost Ark", creation_year: 1981, genre: "Action/Adventure")
    @movie_2 = @studio_1.movies.create!(title: "A Quite Place", creation_year: 2018, genre: "Horror/Sci-fi")
  end
  it 'Shows the studio, its attributes, and its movies' do
    # Story 1
    # Studio Show
    # As a user,
    # When I visit a studio show page
    # I see the studio's name and location
    # And I see the titles of all of its movies
    visit "/studios/#{@studio_1.id}"
    save_and_open_page
    expect(page).to have_content(@studio_1.name)
    expect(page).to have_content(@studio_1.location)
    expect(page).to have_content(@movie_1.title)
    expect(page).to have_content(@movie_2.title)
  end
end

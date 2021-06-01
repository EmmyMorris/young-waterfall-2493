require 'rails_helper'

RSpec.describe 'Studio show page' do
  before(:each) do
    @studio_1 = Studio.create!(name: "Universal Studios", location: "Hollywood")
    @movie_1 = @studio_1.movies.create!(title: "Raiders of the Lost Ark", creation_year: 1981, genre: "Action/Adventure")
    @movie_2 = @studio_1.movies.create!(title: "A Quite Place", creation_year: 2018, genre: "Horror/Sci-fi")

    @actor_1 = @movie_1.actors.create!(name: "Harrison Ford", age: 78, currently_working: false)
    @actor_2 = @movie_1.actors.create!(name: "Karen Allen", age: 69, currently_working: true)
    @actor_3 = @movie_1.actors.create!(name: "Karen Allen", age: 59, currently_working: true)

    @actor_4 = @movie_2.actors.create!(name: "John Krasinski", age: 41, currently_working: true)
    @actor_5 = @movie_2.actors.create!(name: "Emily Blunt", age: 38, currently_working: false)
    @actor_6 = @movie_2.actors.create!(name: "Cillian Murphy", age: 45, currently_working: true)
  end
  it 'Shows the studio, its attributes, and its movies' do
    # Story 1
    # Studio Show
    # As a user,
    # When I visit a studio show page
    # I see the studio's name and location
    # And I see the titles of all of its movies
    visit "/studios/#{@studio_1.id}"
    # save_and_open_page
    expect(page).to have_content(@studio_1.name)
    expect(page).to have_content(@studio_1.location)
    expect(page).to have_content(@movie_1.title)
    expect(page).to have_content(@movie_2.title)
  end

  it "lists actors that have acted in any of the studio's movies" do
    # Story 2
    # Studio's Actors
    # As a user,
    # When I visit a studio show page
    # I see a list of actors that have acted in any of the studio's movies
    # And I see that the list of actors is unique (no duplicate actors)
    # And I see that the list of actors is ordered from oldest actor to youngest
    # And I see that the list of actors only includes actors that are currently working
    visit "/studios/#{@studio_1.id}"
    save_and_open_page
    expect(page).to_not have_content(@actor_1.name)
    expect(page).to have_content(@actor_2.name)
    expect(page).to_not have_content(@actor_3.name)
    expect(page).to have_content(@actor_4.name)
    expect(page).to_not have_content(@actor_5.name)
    expect(page).to have_content(@actor_6.name)

    expect(@actor_2.name).to appear_before(@actor_4.name)
    expect(@actor_6.name).to appear_before(@actor_4.name)
  end
end

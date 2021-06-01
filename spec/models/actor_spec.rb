require 'rails_helper'

RSpec.describe Actor do
  describe 'relationships' do
    it {should have_many(:actor_movies)}
    it {should have_many(:movies).through(:actor_movies)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  it "orders actors oldest to youngest" do
    @studio_1 = Studio.create!(name: "Universal Studios", location: "Hollywood")
    @movie_1 = @studio_1.movies.create!(title: "Raiders of the Lost Ark", creation_year: 1981, genre: "Action/Adventure")
    @movie_2 = @studio_1.movies.create!(title: "A Quite Place", creation_year: 2018, genre: "Horror/Sci-fi")
    
    @actor_1 = @movie_1.actors.create!(name: "Harrison Ford", age: 78, currently_working: false)
    @actor_2 = @movie_1.actors.create!(name: "Karen Allen", age: 69, currently_working: true)
    @actor_3 = @movie_1.actors.create!(name: "Karen Allen", age: 69, currently_working: true)

    @actor_4 = @movie_2.actors.create!(name: "John Krasinski", age: 41, currently_working: true)
    @actor_5 = @movie_2.actors.create!(name: "Emily Blunt", age: 38, currently_working: false)
    @actor_6 = @movie_2.actors.create!(name: "Cillian Murphy", age: 45, currently_working: true)

    expect(Actor.order_by_age).to eq([@actor_1, @actor_2, @actor_3, @actor_6, @actor_4, @actor_5])
  end
end

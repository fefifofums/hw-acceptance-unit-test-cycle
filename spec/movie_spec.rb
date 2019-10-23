require 'rails_helper'

describe Movie do
    it 'should find movies with the same director' do
        movie1 = Movie.create(title: "m1", director: "m")
        movie2 = Movie.create(title: "m2", director: "m")
        results = Movie.same_director(movie1)
        results.each do |movie| expect(movie.director).to eq(movie1.director) end
    end
    
    it 'should return nil when a movie has no director' do
        movie1 = Movie.create(title: "m1")
        results = Movie.same_director(movie1)
        results.each do |movie| expect(movie.director).to eq(nil) end
    end
    
    it 'should have all ratings' do
        expect(Movie.all_ratings).to eq(%w(G PG PG-13 NC-17 R))
    end
    
end


describe ApplicationController do
    it 'should protect from forgery' do
    end
end

describe MoviesHelper do
    include MoviesHelper
    it 'is odd if the count is odd' do
        expect(oddness(1)).to eq('odd')
    end
end

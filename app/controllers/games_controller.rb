require "open-uri"

class GamesController < ApplicationController
  def new
    source = ("A".."Z").to_a
    @letters = []
    for i in 1..10
      @letters << source[rand(26)]
    end
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params["answer"].downcase}.json"
    dico = JSON.parse(open(url).read)
    input = params["answer"].upcase.split("")
    @word = params["answer"].upcase
    @letters = params["tirage"].split(" ")
    value = true
    input.each do |el|
      unless @letters.include?(el)
        @output = "Sorry but #{@word} can't be build out of #{params["tirage"]}"
        value = false
      end
    end
    if value == true
      if dico["found"] == true
        @output = "Congratulations! #{@word} is a valid English word..."
      else
        @output = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    end
  end
end

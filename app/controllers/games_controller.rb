require "open-uri"

class GamesController < ApplicationController
  def home
  end

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end


  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english = word_exists?(@word)
  end

  private

  def word_exists?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    word_hash = JSON.parse(word_serialized)
    word_hash['found']
  end
end

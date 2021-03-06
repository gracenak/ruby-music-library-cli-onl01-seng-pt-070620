require 'pry'
require_relative "../config/environment.rb"

class Genre
    extend Concerns::Findable

    attr_accessor :name, :songs, :artists

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def self.all
         @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(genre)
        genre = self.new(genre)
        genre
    end

    def artists
        self.songs.collect {|song| song.artist}.uniq
    end


end
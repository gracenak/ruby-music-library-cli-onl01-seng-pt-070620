require 'pry'
require_relative "../config/environment.rb"

class Song
    
    attr_accessor :name, :artist, :genre
    
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
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

    def self.create(song)
        song = self.new(song)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist 
           artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
           genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        @@all.find {|song|song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

  
    def self.new_from_filename(filename)
        array = filename.split(" - ")
        artist_name = array[0]
        song_name = array[1]
        genre_name = array[2].split(".mp3").join

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        new_song = Song.new(song_name, artist, genre)
         #binding.pry
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save

    end

end
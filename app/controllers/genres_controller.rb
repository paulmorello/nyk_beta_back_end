class GenresController < ApplicationController
  skip_before_action :authenticate_user!

  def index

    genres = $redis.get('genres')
    if genres.nil?
      puts 'nil'
      @genres = Genre.all
      $redis.set('genres', JSON.generate(@genres.as_json))
      $redis.expire('genres', 300.seconds.to_i)
    else
      puts 'redis'
      @genres = JSON.parse(genres)
    end

    presstypes = $redis.get('presstypes')
    if presstypes.nil?
      puts 'nil'
      @presstypes = Presstype.all
      $redis.set('presstypes', JSON.generate(@presstypes.as_json))
      $redis.expire('presstypes', 300.seconds.to_i)
    else
      puts 'redis'
      @presstypes = JSON.parse(presstypes)
    end

    outlets = $redis.get('outlet_names')
    if outlets.nil?
      puts 'nil'
      @outlets = Outlet.where(inactive: false)
      $redis.set('outlet_names', JSON.generate(@outlets.as_json))
      $redis.expire('outlet_names', 300.seconds.to_i)
    else
      puts 'redis'
      @outlets = JSON.parse(outlets)
    end

    countries = $redis.get('countries')
    # if countries isn't in redis, build it below from scratch below
    if countries.nil?
      puts 'nil'
      @countries = []
      c_arr = []
      @outlets.each do |o|
        c_arr.push(o["country_id"])
      end
      c_arr.uniq!
      c_arr.each do |c_id|
        @countries.push( Country.find_by(id: c_id))
      end
      @countries.sort! { |a,b| a.name.downcase <=> b.name.downcase}
      $redis.set('countries', JSON.generate(@countries.as_json))
      $redis.expire('countries', 300.seconds.to_i)
    else
      #if it is in redis, we parse it and capture it in @countries
      puts 'redis'
      @countries = JSON.parse(countries)
    end

    render json: {genres: @genres, presstypes: @presstypes, countries: @countries, outlets: @outlets}
  end

end

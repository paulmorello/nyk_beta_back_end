class GenresController < ApplicationController
  skip_before_action :authenticate_user!

  def index

    genres = $redis.get('genres')
    if genres.nil?
      puts 'nil'
      @genres = Genre.all
      $redis.set('genres', JSON.generate(@genres.as_json))
      $redis.expire('genres', 5.seconds.to_i)
    else
      puts 'redis'
      @genres = JSON.parse(genres)
    end

    presstypes = $redis.get('presstypes')
    if presstypes.nil?
      puts 'nil'
      @presstypes = Presstype.all
      $redis.set('presstypes', JSON.generate(@presstypes.as_json))
      $redis.expire('presstypes', 5.seconds.to_i)
    else
      puts 'redis'
      @presstypes = JSON.parse(presstypes)
    end

    outlets = $redis.get('outlet_names')
    if outlets.nil?
      puts 'nil'
      @outlets = Outlet.where(inactive: false).order(:name)
      $redis.set('outlet_names', JSON.generate(@outlets.as_json))
      $redis.expire('outlet_names', 5.seconds.to_i)
    else
      puts 'redis'
      @outlets = JSON.parse(outlets)
    end

    active_countries = $redis.get('active_countries')
    # if countries isn't in redis, build it below from scratch below
    if active_countries.nil?
      puts 'nil active countries'
      @active_countries = []
      c_arr = []
      @outlets.each do |o|
        c_arr.push(o["country_id"])
      end
      c_arr.uniq!
      c_arr.each do |c_id|
        @active_countries.push( Country.find_by(id: c_id))
      end
      @active_countries.sort! { |a,b| a.name.downcase <=> b.name.downcase}
      $redis.set('active_countries', JSON.generate(@active_countries.as_json))
      $redis.expire('active_countries', 5.seconds.to_i)
    else
      #if it is in redis, we parse it and capture it in @countries
      puts 'redis'
      @active_countries = JSON.parse(active_countries)
    end

    all_countries = $redis.get('all_countries')
    # if countries isn't in redis, build it below from scratch below
    if all_countries.nil?
      puts 'nil all countries'
      @all_countries = Country.all.order(:name)
      $redis.set('all_countries', JSON.generate(@all_countries.as_json))
      $redis.expire('all_countries', 5.seconds.to_i)
    else
      #if it is in redis, we parse it and capture it in @countries
      puts 'redis'
      @all_countries = JSON.parse(all_countries)
    end

    render json: {genres: @genres, presstypes: @presstypes, active_countries: @active_countries, all_countries: @all_countries, outlets: @outlets}
  end

end

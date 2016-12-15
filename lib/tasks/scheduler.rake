desc "This task is called by the Heroku scheduler add-on to update Outlet and Writer social media numbers"
task :update_social => :environment do
  # Grab count number from DB for handling Outlet offset
  offset = Counter.find(1).count
  # Currently doing 30 Outlets and all their writers per hour.
  limit = 30
  outlet_batch = Outlet.order(:id).where(inactive: false).offset(offset).limit(limit)
  # Iterate through batch of outlets updating social info from APIs
  outlet_batch.each do |outlet|
    # twitter follower
    if outlet.twitter.present?
      credentials = Base64.encode64("#{TWITTER_ID}:#{TWITTER_SECRET}").gsub("\n", '')
      url = "https://api.twitter.com/oauth2/token"
      body = "grant_type=client_credentials"
      headers = {
        "Authorization" => "Basic #{credentials}",
        "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
      }
      r = HTTParty.post(url, body: body, headers: headers)
      bearer_token = JSON.parse(r.body)['access_token']

      api_auth_header = {"Authorization" => "Bearer #{bearer_token}"}
      url = "https://api.twitter.com/1.1/users/show.json?screen_name=#{outlet.twitter}"
      response = HTTParty.get(url, headers: api_auth_header).body
      parsed_response = JSON.parse(response)
      twitter_followers = parsed_response["followers_count"].to_s

      if twitter_followers.present?
        if twitter_followers.length > 3
          twitter_followers = twitter_followers.chop.chop.chop+"k"
        end
        outlet.update(twitter_followers: twitter_followers)
      end
    end

    # facebook follower
    if outlet.facebook.present?
      url = "https://graph.facebook.com/#{outlet.facebook}?fields=fan_count&access_token=#{FACEBOOK_ID}|#{FACEBOOK_SECRET}"
      facebook_response = HTTParty.get url
      parsed_facebook_response = JSON.parse(facebook_response)
      facebook_followers = parsed_facebook_response["fan_count"].to_s
      if facebook_followers.present?
        if facebook_followers.length > 3
          facebook_followers = facebook_followers.chop.chop.chop+"k"
        end
        outlet.update(facebook_likes: facebook_followers)
      end
    end

    # insta follower
    if outlet.instagram.present?
      url = "https://www.instagram.com/web/search/topsearch/?query=#{outlet.name}"
      insta_response = HTTParty.get url
      insta_followers = insta_response["users"].first["user"]["byline"].chomp(" followers")
      if insta_followers.present?
        if insta_followers.length > 3
          insta_followers = insta_followers.chop.chop.chop+"k"
        end
        outlet.update(instagram_followers: insta_followers)
      end
    end
    # Iterate through each writer within each outlet doing the same
    writers_batch = outlet.writers
    writers_batch.each do |writer|
      # twitter follower
      if writer.twitter.present?
        credentials = Base64.encode64("#{TWITTER_ID}:#{TWITTER_SECRET}").gsub("\n", '')
        url = "https://api.twitter.com/oauth2/token"
        body = "grant_type=client_credentials"
        headers = {
          "Authorization" => "Basic #{credentials}",
          "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
        }
        r = HTTParty.post(url, body: body, headers: headers)
        bearer_token = JSON.parse(r.body)['access_token']

        api_auth_header = {"Authorization" => "Bearer #{bearer_token}"}
        url = "https://api.twitter.com/1.1/users/show.json?screen_name=#{writer.twitter}"
        response = HTTParty.get(url, headers: api_auth_header).body
        parsed_response = JSON.parse(response)
        twitter_followers = parsed_response["followers_count"].to_s

        if twitter_followers.present?
          if twitter_followers.length > 3
            twitter_followers = twitter_followers.chop.chop.chop+"k"
          end
          writer.update(twitter_followers: twitter_followers)
        end
      end
    end
  end

  # Once done with current batch of outlets and writers, update count in the DB for next iteration, or if done, reset to starting.
  last_outlet = Outlet.last
  if outlet_batch.include?(last_outlet)
    Counter.find(1).update(count: 0)
  else
    new_count = offset + limit
    Counter.find(1).update(count: new_count)
  end

end

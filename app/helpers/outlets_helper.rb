module OutletsHelper
  ReStrucOutlet = Struct.new(:id, :name, :website, :email, :city, :state, :country_id, :twitter, :facebook, :instagram, :linkedin, :twitter_followers, :facebook_likes, :instagram_followers, :hype_m, :submithub, :flagged, :inactive, :notes, :created_at, :updated_at, :description, :staff_list, :user_id)

  def format_country_id(outlets)
    new_outlets = []
    outlets.each do |outlet|
      new_country = Country.find_by(id: outlet["country_id"]).name
      @outlet = ReStrucOutlet.new(outlet["id"], outlet["name"], outlet["website"], outlet["email"],
        outlet["city"], outlet["state"],
        outlet["country_id"], outlet["twitter"], outlet["facebook"],
        outlet["instagram"], outlet["linkedin"], outlet["twitter_followers"],
        outlet["facebook_likes"], outlet["instagram_followers"], outlet["hype_m"],
        outlet["submithub"], outlet["flagged"],
        outlet["inactive"], outlet["notes"],
        outlet["created_at"], outlet["updated_at"],
        outlet["description"], outlet["staff_list"], outlet["user_id"]).to_h
      @outlet[:country_id] = new_country
      new_outlets.push(@outlet)
    end
    @new_outlets = new_outlets
  end




  def reshape_data(outlet)
    outlet.each do |outlet|
      exported_outlet = ReStrucOutlet.new(outlet.id, outlet.name, outlet.website, outlet.email, outlet.city, outlet.state, outlet.country_id, outlet.twitter, outlet.facebook, outlet.instagram, outlet.linkedin, outlet.twitter_followers, outlet.facebook_likes, outlet.instagram_followers, outlet.hype_m, outlet.submithub, outlet.flagged, outlet.inactive, outlet.notes, outlet.created_at, outlet.updated_at, outlet.description, outlet.staff_list, outlet.user_id)
      @exported_outlet = exported_outlet.to_h
      @exported_outlet[:country_id] = Country.find_by(id: exported_outlet.country_id).name
      @exported_outlet[:jobs] = []
      @exported_outlet[:genres] = []
      @exported_outlet[:presstypes] = []
      outlet.jobs.each do |job|
        if job.writer.inactive == false
          genres = []
          presstypes = []
          job.writer.genre_tags.each do |gtag|
            genres.push(Genre.find_by(id: gtag.genre_id).name)
          end
          job.presstype_tags.each do |ptag|
              presstypes.push(Presstype.find_by(id: ptag.presstype_id).name)
          end
          jobsOutlet = Outlet.find_by(id: job.outlet_id)
          jobsWriter = Writer.find_by(id: job.writer_id)
          @exported_outlet[:jobs].push({
            job_id: job.id,
            position: job.position,
            outlet: jobsOutlet.name,
            key_contact: job.key_contact,
            email_work: job.email_work,
            writer: {
              f_name: jobsWriter.f_name,
              l_name: jobsWriter.l_name,
              email_personal: jobsWriter.email_personal,
              writer_id: jobsWriter.id
              }
            })
            @exported_outlet[:genres] = genres.uniq
            @exported_outlet[:presstypes] = presstypes.uniq
        end
      end
    end
    @exported_outlet
  end



end

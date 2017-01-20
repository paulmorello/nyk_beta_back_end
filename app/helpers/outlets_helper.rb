module OutletsHelper
  ReStrucOutlet = Struct.new(:id, :name, :website, :email, :city, :state, :country_id, :twitter, :facebook, :instagram, :linkedin, :twitter_followers, :facebook_likes, :instagram_followers, :hype_m, :submithub, :flagged, :inactive, :notes, :created_at, :updated_at, :description, :staff_list, :user_id)

  def reshape_data(outlet)
    outlet.each do |outlet|
      exported_outlet = ReStrucOutlet.new(outlet.id, outlet.name, outlet.website, outlet.city, outlet.state, outlet.country_id, outlet.twitter, outlet.facebook, outlet.instagram, outlet.linkedin, outlet.twitter_followers, outlet.facebook_likes, outlet.instagram_followers, outlet.hype_m, outlet.submithub, outlet.flagged, outlet.inactive, outlet.notes, outlet.created_at, outlet.updated_at, outlet.description, outlet.staff_list, outlet.user_id)
      @exported_outlet = exported_outlet.to_h
      @exported_outlet[:jobs] = []
      @exported_outlet[:genres] = []
      @exported_outlet[:presstypes] = []
      outlet.jobs.each do |job|
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
          key_contatact: job.key_contact,
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
    @exported_outlet
  end
end

# Genre.where(id: outlet[0].jobs[0].writer.genre_tags[0].genre_id)[0].name

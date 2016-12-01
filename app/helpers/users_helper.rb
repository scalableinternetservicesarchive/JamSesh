module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, clazz="pull-left", size='80x80')
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.profile.full_name, class: "#{clazz}", size: size)
  end

  def cache_key_for_profile(prof)
    "profile/#{prof.id}/#{prof.updated_at}/#{prof.instrument.count}"
  end

  def cache_key_for_profile_listing
    "profile_table/#{Profile.maximum(:updated_at)}/#{InstrumentProfile.maximum(:updated_at).to_s}"
  end
end

module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, clazz="pull-left", size='80x80')
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.profile.full_name, class: "#{clazz}", size: size)
  end
end

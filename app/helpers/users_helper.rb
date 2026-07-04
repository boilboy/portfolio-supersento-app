module UsersHelper
  def gravatar_for(user, size: 80, classes: "gravatar")
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase.strip)

    gravatar_url = "https://gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mp"

    image_tag(gravatar_url, alt: user.nickname, class: classes)
  end
end

module UsersHelper
  def steam_profile_path(user)
    "https://steamcommunity.com/profiles/#{user.uid}"
  end
end

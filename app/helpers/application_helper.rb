module ApplicationHelper
  def guest_expires_at_in_words(user)
    distance_of_time_in_words(Time.now,
                              user.remember_me_token_expires_at)
  end

  def bookmarklet
    redirect = new_shot_url(protocol: 'http')
    exturl = "window.btoa(location.href)"
    title = "window.btoa(window.document.title)"
    %(javascript:(function(){window.open('#{redirect}?exturl='+#{exturl}+'&title='+#{title});})();)
  end
end

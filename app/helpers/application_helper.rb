module ApplicationHelper
  def latest_ot_release_path
    "https://github.com/fapper/openTracker/raw/master/openTracker-1.0.1.zip"
  end

  def fapper_twitter_path
    'https://twitter.com/fapper'
  end

  def format_ms(s)
    ms = s % 1000
    s = (s - ms) / 1000
    secs = s % 60
    s = (s - secs) / 60
    mins = s % 60
    hrs = (s - mins) / 60

    if hrs > 0
      "#{hrs}:#{mins}:#{secs}.#{ms.to_s[0]}"
    else
      "#{mins}:#{secs}.#{ms.to_s[0]}"
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
end

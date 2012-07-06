module ForumThreadsHelper
  def get_author(author_id)
    User.find(author_id)
  end

  # @param [Object] forum_threads
  def nested_threads(forum_threads)
    forum_threads.map do |forum_thread, sub_threads|
      render(forum_thread) + content_tag(:div, nested_threads(sub_threads), :class => "nested_threads")
    end.join.html_safe
  end

  def get_forum_title(forum_thread)
    Forum.find(forum_thread.forum_id).forum_title;
  end

end

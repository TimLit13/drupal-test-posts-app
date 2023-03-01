module CommentsHelper
  def format_time(updated_at_time)
    updated_at_time.strftime('%T')
  end
end

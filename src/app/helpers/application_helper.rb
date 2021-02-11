module ApplicationHelper

  # Return Full title
  def full_title(page_title = '')
    base_title = 'ぽすといっと！'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

end

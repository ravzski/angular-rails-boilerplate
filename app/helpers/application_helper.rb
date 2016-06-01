module ApplicationHelper

  def nl2br(s)
    s.gsub(/\n/, '<br>')
  end

  def format_date(date)
    return date.blank? ? "" : date.strftime(DATE_FORMAT)
  end
end

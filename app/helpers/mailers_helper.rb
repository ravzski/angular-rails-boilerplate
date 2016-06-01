module MailersHelper
  def is_single_day? _start, _end
    return true if _end.blank?

    _start === _end
  end

  def is_same_month? _start, _end
    return true if _end.blank?

    _start.strftime("%b%Y") == _end.strftime("%b%Y")
  end

  def to_date_range _start, _end
    if is_single_day? _start, _end
      _start.strftime("%b %-d, %Y")
    else
      if is_same_month? _start, _end
        _start.strftime("%b %-d - ") + _end.strftime("%-d, %Y")
      else
        _start.strftime("%b %-d, %Y") + "-" + _end.strftime("%b %-d, %Y")
      end
    end
  end

  def build_previous_date_range p_start, p_end, _start, _end
    to_date_range(
      p_start.present? ? p_start : _start,
      p_end.present? ? p_end : _end
    )
  end
end

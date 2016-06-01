module CommonScopes
  extend ActiveSupport::Concern

  module ClassMethods

    # NOTE: strftime("%Y-%m-%d %H:%M:%S") ignores timezone adjustments
    # NOTE: table_name is where should the date range referencing table
    # NOTE: use these utilitie scopes for finding date ranges
    # NOTE: these are just collection of date range helpers

    def this_week table_name=nil
      date_range Time.zone.now .beginning_of_week,Time.zone.now .end_of_week, table_name
    end

    def two_weeks_ago table_name=nil
      weeks_ago 2
    end

    def last_week table_name=nil
      weeks_ago 1
    end

    def weeks_ago no_of_weeks=nil
      days_offset = (no_of_weeks*7).days
      date_range Time.zone.now .beginning_of_week-days_offset,Time.zone.now .beginning_of_week-1.hour, table_name
    end

    def today table_name=nil
      date_range Time.zone.now .beginning_of_day,Time.zone.now .end_of_day,table_name
    end

    def date_range from, to, table_name=nil,column_name=nil
      table_name = table_name.present? ? table_name : self.table_name
      column_name = column_name.present? ? column_name : "updated_at"
      where("#{table_name}.#{column_name}::DATE >= ?",from).
      where("#{table_name}.#{column_name}::DATE <= ?",to)
    end

    def previous_week from, to, table_name=nil
      table_name = table_name.present? ? table_name : self.table_name
      to = (to.to_date-7.days).strftime("%Y-%m-%d")
      from = (from.to_date-7.days).strftime("%Y-%m-%d")
      where("#{table_name}.updated_at::DATE >= ?",from).
      where("#{table_name}.updated_at::DATE <= ?",to)
    end

    #
    # query with limit
    # simplier alternative for load more features
    #
    def by_limit page, limit
      limit(limit).offset(limit*(page.to_i-1))
    end

    #
    # Use in pagination
    #
    def total_count
      select("count(*) as total_count").except(:offset, :limit, :order)[0].total_count
    end

    #
    # common active only query filter
    #
    def active
      where(active: true)
    end

  end

  #
  # common scopes
  # only put scopes with conditional
  # so that it will be chainable
  #
  included do
    scope :where_timestamp_is, -> ts { where("exams.updated_at > ?", ts) if ts !="-1"}
    scope :not_self, -> id { where("id != ?", id) if id.present? }
    scope :by_field, -> field,id { where("#{field} = ?", id) if id.present? }
    scope :where_like, ->(column,value){ where("#{column} LIKE LOWER(?)",  "#{value}%") if value.present? }
    scope :by_status, -> status { where(status: status) if status.present? }
  end

  private


end

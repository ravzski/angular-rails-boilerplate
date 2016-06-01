module Cachable
  extend ActiveSupport::Concern

  def update_cache
    if $redis.set("#{self.class.table_name}/#{self.id}", self.to_json) == "OK"
      true
    else
      false
    end
  end

  def update_token_cache
    if $redis.set("users/#{self.id}", self.access_token) == "OK"
      true
    else
      false
    end
  end

end

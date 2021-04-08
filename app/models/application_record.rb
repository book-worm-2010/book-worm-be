class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.paginate(per_page, page)
    limit = (per_page || 20).to_i
    records = ((page || 1).to_i - 1) * limit
    limit(limit).offset(records)
  end
end

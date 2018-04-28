class News < ApplicationRecord
  default_scope { order(created_at: :desc) }

  def to_s
    self.title
  end
end

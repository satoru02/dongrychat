module Pager
  extend ActiveSupport::Concern

  included do
    scope :pager, ->(page: 1, per: 10) {
      num = page.to_i.positive? ? page.to_i - 1 : 0
      limit(per).offset(per.to_i * num)
    }
  end
end
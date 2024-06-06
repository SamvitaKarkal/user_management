class User < ApplicationRecord
  validates :uuid, uniqueness: true
end

class Link < ApplicationRecord
  validates :original, :suffix, presence: true
  validates :suffix, uniqueness: true

  class << self
    def gen_suffix
      SecureRandom.alphanumeric(3) + 'X'
    end
  end

  def short
    [ENV['APP_URL'], suffix].join('/')
  end
end

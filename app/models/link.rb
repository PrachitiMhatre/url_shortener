class Link < ApplicationRecord
  before_validation :generate_short_code
  validates :original_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }
  validates :short_code, uniqueness: true

  def short_url
    Rails.application.routes.url_helpers.short_url(short_code: short_code, host: Rails.application.routes.default_url_options[:host])
  end

  private

  def generate_short_code
    self.short_code ||= SecureRandom.alphanumeric(6)
  end
end

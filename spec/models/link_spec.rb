require 'rails_helper'

RSpec.describe Link, type: :model do
  describe "validations" do
    it "is valid with a properly formatted URL" do
      link = Link.new(original_url: "https://example.com")
      expect(link).to be_valid
    end

    it "is invalid without a URL" do
      link = Link.new(original_url: nil)
      expect(link).not_to be_valid
      expect(link.errors[:original_url]).to include("can't be blank")
    end

    it "is invalid with an incorrectly formatted URL" do
      link = Link.new(original_url: "not_a_url")
      expect(link).not_to be_valid
      expect(link.errors[:original_url]).to include("must be a valid URL")
    end

    it "ensures short_code is unique" do
      existing = Link.create!(original_url: "https://example.com")
      duplicate = Link.new(original_url: "https://another.com", short_code: existing.short_code)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:short_code]).to include("has already been taken")
    end
  end

  describe "short code generation" do
    it "generates a short_code before validation if not present" do
      link = Link.new(original_url: "https://example.com")
      link.valid? # triggers validation
      expect(link.short_code).to be_present
    end

    it "does not overwrite existing short_code" do
      link = Link.new(original_url: "https://example.com", short_code: "custom123")
      link.valid?
      expect(link.short_code).to eq("custom123")
    end
  end

  describe "#short_url" do
    it "generates a full short URL with host" do
      Rails.application.routes.default_url_options[:host] = "localhost:3000"
      link = Link.create!(original_url: "https://example.com")
      expect(link.short_url).to eq("http://localhost:3000/#{link.short_code}")
    end
  end
end

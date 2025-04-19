require 'rails_helper'

RSpec.describe "links/index", type: :view do
  before do
    assign(:links, [
      Link.create!(original_url: "https://example.com", short_code: "abc123"),
      Link.create!(original_url: "https://google.com", short_code: "xyz789")
    ])
    render
  end

  it "displays all shortened links in a table" do
    expect(rendered).to have_selector("table")
    expect(rendered).to include("https://example.com")
    expect(rendered).to include("https://google.com")
    expect(rendered).to include("abc123")
    expect(rendered).to include("xyz789")
  end

  it "includes Copy buttons" do
    expect(rendered).to have_text("Copy").at_least(1)
  end
end

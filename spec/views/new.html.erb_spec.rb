require 'rails_helper'

RSpec.describe "links/new", type: :view do
  before do
    assign(:link, Link.new)
    render
  end

  it "renders the form to shorten a URL" do
    expect(rendered).to have_selector("form")
    expect(rendered).to have_field("link[original_url]")
    expect(rendered).to have_button("Shorten")
  end

  it "displays the correct page title" do
    expect(rendered).to include("Shorten URL")
  end
end
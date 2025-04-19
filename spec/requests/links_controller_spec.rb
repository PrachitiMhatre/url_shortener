# spec/requests/links_spec.rb
require 'rails_helper'

RSpec.describe LinksController, type: :request do
  describe "GET /new" do
    it "renders the new template" do
      get new_link_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Shorten URL")
    end
  end

  describe "POST /create" do
    context "with valid URL" do
      it "creates a link and redirects to index" do
        expect {
          post links_path, params: { link: { original_url: "https://example.com" } }
        }.to change(Link, :count).by(1)

        expect(response).to redirect_to(links_path)
        follow_redirect!
        expect(response.body).to include("Short URL created!")
      end
    end

    context "with invalid URL" do
      it "does not create a link and renders new" do
        expect {
          post links_path, params: { link: { original_url: "not-a-url" } }
        }.not_to change(Link, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("must be a valid URL")
      end
    end
  end

  describe "GET /index" do
    it "renders all shortened links" do
      Link.create!(original_url: "https://test.com")
      get links_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("https://test.com")
    end
  end

  describe "GET /:short_code" do
    context "when link exists" do
      it "redirects to the original URL" do
        link = Link.create!(original_url: "https://example.com")
        get short_url(short_code: link.short_code)
        expect(response).to redirect_to(link.original_url)
      end
    end

    context "when link does not exist" do
      it "returns 404 with message" do
        get short_url(short_code: "notfound")
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("URL not found")
      end
    end
  end
end

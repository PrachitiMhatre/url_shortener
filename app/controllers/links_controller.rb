class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to links_path, notice: "Short URL created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @links = Link.all.order(created_at: :desc)
  end

  def show
    @link = Link.find_by(short_code: params[:short_code])
    if @link
      redirect_to @link.original_url, allow_other_host: true
    else
      render plain: "URL not found", status: :not_found
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end
end

class ShotsController < ApplicationController
  skip_before_filter :require_login, only: [:index]

  def index
    if params[:tag]
      @shots = Tag.find_by(name: params[:tag]).shots.shuffle
    else
      @shots = Shot.all.shuffle
    end
    @tags = Tag.all.includes(:shots)
  end

  def new
    name = Base64.decode64(params[:title])
    url = Base64.decode64(params[:exturl])

    @shot = Shot.new(name: name, url: url)
    @shot.fetch_screenshot(url)
  end

  def create
    @shot = Shot.new(shot_params)
    @shot.user = current_user
    @shot.tmp_image, @shot.image = @shot.crop_screenshot

    if @shot.save
      @shot.tag_list.split(',').each do |name|
        @shot.tags << Tag.find_or_create_by(name: name)
      end

      redirect_to confirmation_shots_path, notice: "Your shot is saved! You can close this browser tab/window."
    else
      render :new
    end
  end

  def destroy
    @shot = Shot.find(params[:id])
    if @shot.user == current_user
      @shot.destroy
      Amazon.bucket.find(@shot.image).destroy
      redirect_to profile_path
    else
      not_authorized
    end
  end

  private

  def shot_params
    params.require(:shot).permit(:name, :url, :crop_x, :crop_y, :crop_w, :crop_h, :filename, :tag_list)
  end
end

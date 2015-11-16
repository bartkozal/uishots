class TagsController < ApplicationController
  skip_before_filter :require_login

  def index
    render json: Tag.all.map(&:name).to_json
  end
end

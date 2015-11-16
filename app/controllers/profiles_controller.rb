class ProfilesController < ApplicationController
  def show
    if params[:tag]
      @shots = find_shots.find_all do |shot|
        shot.tags.map(&:name).include?(params[:tag])
      end
    else
      @shots = find_shots
    end
    @tags = current_user.tags_and_pinned_tags.group_by(&:name)
    @pinned_tags = current_user.pinned_tags.group_by(&:name)
  end

  private

  def find_shots
    params[:pins] ? current_user.pinned_shots : current_user.shots_and_pinned_shots
  end
end

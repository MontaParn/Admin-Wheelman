class PodiumController < ApplicationController
  def index
    @by_tenure = Podium.by_tenure
    @by_punctuality = Podium.by_punctuality
    @by_race_count = Podium.by_race_count
  end
end

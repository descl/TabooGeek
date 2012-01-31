class GameController < ApplicationController
  def game
    @get = Get.find(params[:q])
    
  end
end

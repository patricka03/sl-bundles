class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @threeHair = Hair.limit(3)
  end
end

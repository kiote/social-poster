class StaticPagesController < ApplicationController
  
  layout "social_poster"
  
  def test
    @test_value = params[:social_network][:name]
  end
  
end

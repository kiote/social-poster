class StaticPagesController < ApplicationController
  
  def home
  end
  
  def test
    @test_value = params[:social_network][:name]
  end
  
end

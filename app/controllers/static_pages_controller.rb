class StaticPagesController < ApplicationController
  
  def home
  end
  
  def test
    @test_value = params[:social_network][:name]
  end
  
  def wysihtml5
  end
  
  def wysihtml5_bootstrap
  end
  
end

class TemplatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    
  end

  def template
    render :template => 'templates/' + params[:path], :layout => nil
  end
  
end

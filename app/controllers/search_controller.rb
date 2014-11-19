class SearchController < ApplicationController

  before_action :load_type

  def index
    @found_objects = @search_object.search(params[:search])
  end

  private

  def load_type
     @search_object = params[:type].constantize if %w[ThinkingSphinx Question Answer Comment User].include?(params[:type])
  end

end

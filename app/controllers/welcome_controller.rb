class WelcomeController < ApplicationController

  layout "welcome", only: [:about, :contact]

  def index
  end
  def about
  end
  def contact
  end
end

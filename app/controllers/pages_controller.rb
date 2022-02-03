class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def main
  end

  def about
  end

  def subscription
  end
end

class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :render_content
  before_action :newest_user, only: :main

  private

  def newest_user
    @newest_user = User.last
  end

  def render_content
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    @content = markdown.render(File.read("#{Rails.root}/public/#{action_name}.md"))
  end
end

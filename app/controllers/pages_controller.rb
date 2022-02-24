class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :render_content

  private

  def render_content
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    @content = markdown.render(File.read("#{Rails.root}/public/#{action_name}.md"))
  end
end

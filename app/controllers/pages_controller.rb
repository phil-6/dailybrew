class PagesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :render_content

  def main; end

  def about; end

  def subscription; end

  def terms; end

  private

  def render_content
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    @content = markdown.render(File.read("#{Rails.root}/public/#{action_name}.md"))
  end
end

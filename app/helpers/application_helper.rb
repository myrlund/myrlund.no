module ApplicationHelper
  
  def user_image(user, size=65)
    return nil unless user.email
    
    email = user.email.downcase.strip
    hash = Digest::MD5.hexdigest(email)
    
    image_tag "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
  
  def markdown(text)
    renderer = HTMLwithPygments.new(hard_wrap: false, filter_html: true, with_toc_data: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      # lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
  
  def title(str=nil)
    content_for(:title){ str } unless str.nil?
    
    content_for(:title)
  end
  def print_title(tagline=nil)
    title_text = content_for(:title)
    title_text += content_tag('small', " " + tagline) unless tagline.nil?
    content_tag('div', content_tag('h1', title_text), class: 'page-header')
  end
  
end

class HTMLwithPygments < Redcarpet::Render::HTML
  include ActionView::Helpers::UrlHelper
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  
  def block_code(code, language)
    sha = Digest::SHA1.hexdigest(code)
    Rails.cache.fetch ["code", language, sha].join('-') do
      Pygments.highlight(code, lexer: language)
    end
  end
  def image(link, title, alt_text)
    image_tag(link, :title => title, :alt => alt_text, :class => 'img-polaroid')
  end
  def block_quote(quote)
    content_tag(:blockquote, quote, class: 'foobar')
  end
end

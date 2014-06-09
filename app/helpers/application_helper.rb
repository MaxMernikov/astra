module ApplicationHelper
  def active_menu controller
    'uk-active' if params[:controller] == controller
  end

  def mark(text)
    if text
      @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(render_options = {hard_wrap: true}) )
      raw "<div class='mark'>" + @markdown.render(text) + '</div>'
    end
  end

  def block_former(blocks)
    row_blocks = []

    inverse = blocks.size%5 == 2

    blocks.each_slice(5).each do |b|
      if inverse
        row_blocks << b.take(2)
        row_blocks << b.drop(2) if b.size > 2
      else
        row_blocks << b.take(3)
        row_blocks << b.drop(3) if b.size > 3
      end
    end

    result = ''
    row_blocks.each{ |i| result += render("partials/block_row", blocks: i) }
    raw result
  end

  def block_row_class(size)
    case size
    when 1
      'uk-width-1-1 uk-width-medium-1-3 uk-push-1-3'
    when 2
      'uk-width-1-1 uk-width-medium-1-3 uk-push-1-6'
    when 3
      'uk-width-1-1 uk-width-medium-1-3'
    end
  end
end

module ApplicationHelper
  def render_errors(object, method)
    err = object.errors[method]
    unless err.nil?
      err.map{ |e| e.to_s }.join
    end
  end

  def sort_icon(column)
    if @sort_column == column.to_s
      if @sort_direction == 'asc'
        content_tag(:i, '', class: 'fas fa-sort-up')
      else
        content_tag(:i, '', class: 'fas fa-sort-down')
      end
    end
  end
end

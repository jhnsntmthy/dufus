require 'action_view'

# raise a 404, not a 500 if we first access the exposed method in a view
class ActionView::Template
  def render_template(view, local_assigns = {})
    render(view, local_assigns)
  rescue Exception => e
    view.response.status = 404 if e.is_a?(ActiveRecord::RecordNotFound)
    raise e
  end
end

ActionView::Base.class_eval { def assign_variables_from_controller; end }

require 'action_controller'

module ExposeModel
  VERSION = '0.0.2'

  def self.included(base) #:nodoc:
    base.extend(ClassMethods)
  end

  module ClassMethods
    def expose_model(model = nil)
      raise ArgumentError.new('expose_model requires a model name') if model.nil?
      model = model.to_s
      models = model.pluralize
      class_name = model.camelize

      class_eval(
        <<-EOM
          helper_method :#{model}, :#{models}

          def #{models}
            @#{models} ||= #{class_name}.all
          end
          private :#{models}

          def #{model}
            @#{model} ||= if params[:id]
              #{class_name}.find params[:id]
            else
              #{class_name}.new params[:#{model}]
            end
          end
          private :#{model}
        EOM
      )
    end
  end
end

ActionController::Base.class_eval {
  def add_instance_variables_to_assigns; end
  include ExposeModel
}

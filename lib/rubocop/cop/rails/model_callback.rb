require 'pry'

module RuboCop
  module Cop
    module Rails
      class ModelCallback < Cop
        MSG = "not sorted"
        MethodNames = %i[
          after_initialize
          after_find
          after_touch

          before_validation
          validates
          validate
          after_validation

          before_save
          around_save
          before_create
          around_create
          before_update
          around_update
          before_destroy
          around_destroy

          after_destroy
          after_update
          after_create
          after_save
          after_commit
          after_rollback
        ]

        def on_class(node)
          _name, _superclass, body = *node
          callbacks = body.children.select{|x| x.send_type? && MethodNames.include?(x.method_name)}
          return if callbacks == sort_callbacks(callbacks)

          add_offense(callbacks.first, :expression)
        end


        private

        def sort_callbacks(callbacks)
          callbacks.sort_by{|x| MethodNames.find_index(x.method_name)}
        end
      end
    end
  end
end

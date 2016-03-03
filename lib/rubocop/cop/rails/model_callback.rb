require 'pry'

module RuboCop
  module Cop
    module Rails
      class ModelCallback < Cop
        MSG = "not sorted"

        Associations = %i[
          belongs_to
          has_many
          has_one
          has_and_belongs_to_many
        ].freeze

        Callbacks = %i[
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
        ].freeze

        Others = %i[
          attr_readonly
          serialize
        ]

        def on_class(node)
          _name, _superclass, body = *node
          return unless body
          return unless body.begin_type?

          target = target_methods(body)
          return if target == sort_callbacks(target)

          add_offense(target.first, :expression)
        end

        def autocorrect(node)
        end


        private

        def target_methods(body)
          body.children.compact.select do |x|
            x.send_type? && target_method_names.include?(x.method_name)
          end
        end

        def target_method_names
          [Associations, Callbacks, Others].flatten
        end

        def sort_callbacks(callbacks)
          callbacks.sort_by{|x| target_method_names.find_index(x.method_name)}
        end
      end
    end
  end
end

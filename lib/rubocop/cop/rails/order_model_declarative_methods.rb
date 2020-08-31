module RuboCop
  module Cop
    module Rails
      class OrderModelDeclarativeMethods < Base
        extend AutoCorrector

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

          targets = target_methods(body)
          return if targets == sort_methods(targets)

          targets = target_methods(body)
          sorteds = sort_methods(targets)
          sorteds.push(nil)

          add_offense(node.loc.expression, message: MSG) do |corrector|
            sorteds.each_cons(2).with_index do |(sorted, next_sorted), idx|
              target = targets[idx]
              expr = target.loc.expression
              corrector.replace(
                expr,
                sorted.loc.expression.source.to_s
              )

              lnum = expr.last_line
              loop do
                l = processed_source.lines[lnum]
                break if l !~ /\A[[:space:]]*\z/ # blank

                range = source_range(expr.source_buffer, lnum+1, 0, l.size+1)
                corrector.remove(range)
                lnum += 1
              end

              if next_sorted
                corrector.insert_after(expr, "\n") if method_type(sorted) != method_type(next_sorted)
              else
                corrector.insert_after(expr, "\n")
              end
            end
          end
        end

        private

        def source_range(source_buffer, line_number, column, length = 1)
          if column.is_a?(Range)
            column_index = column.begin
            length = column.size
          else
            column_index = column
          end

          line_begin_pos = if line_number.zero?
                             0
                           else
                             source_buffer.line_range(line_number).begin_pos
                           end
          begin_pos = line_begin_pos + column_index
          end_pos = begin_pos + length

          Parser::Source::Range.new(source_buffer, begin_pos, end_pos)
        end

        def target_methods(body)
          body.children.compact.select do |x|
            x.send_type? && target_method_names.include?(x.method_name)
          end
        end

        def target_method_names
          [Associations, Callbacks, Others].flatten
        end

        # TODO: Rename
        def sort_methods(callbacks)
          i = 0
          callbacks.sort_by{|x| [target_method_names.find_index(x.method_name), i+=1]}
        end

        def method_type(target)
          if Associations.include?(target.method_name)
            :association
          elsif Callbacks.include?(target.method_name)
            :callback
          elsif Others.include?(target.method_name)
            :other
          else
            raise "Unreachable code"
          end
        end
      end
    end
  end
end

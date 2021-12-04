# https://thecodest.co/blog/graphql-ruby-what-about-performance/
# lib/my_custom_tracer.rb
# class MyCustomTracer < GraphQL::Tracing::PlatformTracing
#   self.platform_keys = {
#     "lex" => "graphql.lex",
#     "parse" => "graphql.parse",
#     "validate" => "graphql.validate",
#     "analyze_query" => "graphql.analyze_query",
#     "analyze_multiplex" => "graphql.analyze_multiplex",
#     "execute_multiplex" => "graphql.execute_multiplex",
#     "execute_query" => "graphql.execute_query",
#     "execute_query_lazy" => "graphql.execute_query_lazy"
#   }

#   def platform_trace(platform_key, key, _data, &block)
#     start = ::Process.clock_gettime ::Process::CLOCK_MONOTONIC
#     result = block.call
#     duration = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC) - start
#     observe(platform_key, key, duration)
#     result
#   end

#   def platform_field_key(type, field)
#     "graphql.#{type.graphql_name}.#{field.graphql_name}"
#   end

#   def platform_authorized_key(type)
#     "graphql.authorized.#{type.graphql_name}"
#   end

#   def platform_resolve_type_key(type)
#     "graphql.resolve_type.#{type.graphql_name}"
#   end

#   def observe(platform_key, key, duration)
#     return if key == "authorized"

#     puts "platform_key: #{platform_key}, key: #{key}, duration: #{(duration * 1000).round(5)} ms".yellow
#   end
# end

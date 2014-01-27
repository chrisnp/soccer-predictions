module SoccerPredictions
  module ActsAs
    module Scoped
      Scopes = Module.new

      module ClassMethods
        def acts_as_scoped(relation_name)
          @@relation_name = relation_name
        end

        def scope(name, lambda)
          Scopes.module_eval do
            define_method name do |*args|
              instance_exec(*args, &lambda).extend(Scopes)
            end
          end
        end 

        def all
          SoccerPredictions::ROM[relation_name].extend(Scopes)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end  
    end
  end
end
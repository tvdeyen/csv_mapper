module CSVMapper
	module I18nHelpers

		def self.included(controller)
			if controller.respond_to?(:helper_method)
				controller.send(:helper_method, [:csv_mapper_t])
			end
		end

		# This is a proxy to the ::I18n.t method with an csv_mapper scope.
		#
		# === NOTE:
		#
		# The keys are scoped into +csv_mapper+ namespace.
		# Even if you pass a scope this is scoped under +csv_mapper+.
		#
		def csv_mapper_t(key, options={})
			scope = options[:scope].blank? ? 'csv_mapper' : "csv_mapper.#{options.delete(:scope)}"
			::I18n.t(key, {:scope => scope, :default => key.to_s.humanize}.merge(options))
		end

	end
end

module CSVMagic
	module I18nHelpers

		def self.included(controller)
			if controller.respond_to?(:helper_method)
				controller.send(:helper_method, [:csv_magic_t])
			end
		end

		# This is a proxy to the ::I18n.t method with an csv_magic scope.
		# 
		# === NOTE:
		# 
		# The keys are scoped into +csv_magic+ namespace.
		# Even if you pass a scope this is scoped under +csv_magic+.
		# 
		def csv_magic_t(key, options={})
			scope = options[:scope].blank? ? 'csv_magic' : "csv_magic.#{options.delete(:scope)}"
			::I18n.t(key, {:scope => scope, :default => key.to_s.humanize}.merge(options))
		end

	end
end

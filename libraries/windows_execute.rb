class Chef
  class Resource::WindowsExecute < Resource::Execute
    def initialize(name, run_context=nil)
      super
      @resource_name = :windows_execute
    end

    def password(arg=nil)
      set_or_return(:password, arg, :kind_of => String)
    end
  end

  class Provider::WindowsExecute < Provider::Execute
    def shell_out!(cmd, opts)
      opts[:password] = new_resource.password if new_resource.password
      super
    end
  end
end

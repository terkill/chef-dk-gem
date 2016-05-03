# configure a gem using chefdk gemset

def whyrun_supported?
  true
end

provides :chef_dk_gem_gem, platform_family: 'windows'

action :install do
  Chef::Log.debug "Installing chef gem #{new_resource.name}"
  command = "C:\\opscode\\chefdk\\bin\\chef.bat exec gem install \
    #{new_resource.name} #{'--version' unless new_resource.version.nil?}\
    #{new_resource.version unless new_resource.version.nil?}"

  unless ::File.exist?("#{Dir.home(new_resource.user)}/AppData/Local/chefdk/gem/\
              ruby/\2.1.0/gems/#{new_resource.name}-\
              #{new_resource.version unless new_resource.version.nil?}*")
      x = new_resource.user.split '\\'
      require 'win32/process'
      ::Process.create(:command_line => command,
                       :domain => x[0],
                       :with_logon => x[1],
                       :password => new_resource.password)
      new_resource.updated_by_last_action(true)
  end
end

action :remove do
  Chef::Log.debug "Uninstalling chef gem #{new_resource.name}"
  command = "chef exec gem uninstall #{'-a' if new_resource.version.nil?} \
    #{new_resource.name} #{'--version' unless new_resource.version.nil?} \
    #{new_resource.version unless new_resource.version.nil?}"

  x = new_resource.user.split '\\'
  require 'win32/process'
  ::Process.create(:command_line => command,
                   :domain => x[0],
                   :with_logon => x[1],
                   :password => new_resource.password,
                   :cwd => Dir.home(new_resource.user))
  new_resource.updated_by_last_action(true)
end

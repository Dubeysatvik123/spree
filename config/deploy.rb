# config valid for current version and patch releases of Capistrano
lock "~> 3.17"

set :application, "spree"
set :repo_url, "git@github.com:Dubeysatvik123/spree.git"

set :deploy_to, "/home/deploy/spree"
set :branch, "main"

# Linked files and dirs
set :linked_files, %w[config/database.yml config/master.key]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets public/system vendor/bundle public/uploads]

set :keep_releases, 5

# Bundler
set :bundle_path, -> { shared_path.join("vendor/bundle") }

# Puma
set :puma_threads, [4, 16]
set :puma_workers, 2
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"

# Fixed: logs should live in shared_path so they persist across deploys
set :puma_access_log, "#{shared_path}/log/puma.access.log"
set :puma_error_log,  "#{shared_path}/log/puma.error.log"

set :puma_systemctl_user, :system
set :puma_enable_socket_service, true

# Rbenv
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'
set :rbenv_path, '/home/deploy/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_roles, :all

# Fix log permissions after shared symlinks are created
namespace :deploy do
  after 'deploy:symlink:shared', :fix_log_permissions do
    on roles(:app) do
      execute :chown, '-R', 'deploy:deploy', "#{shared_path}/log"
      execute :chmod, '-R', '775', "#{shared_path}/log"
    end
  end

  # Verify master.key exists on server before deploy proceeds
  before :starting, :check_master_key do
    on roles(:app) do
      unless test("[ -f #{shared_path}/config/master.key ]")
        raise "master.key is missing from #{shared_path}/config/! Upload it first."
      end
    end
  end
end
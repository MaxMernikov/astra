set :application, 'astra'
set :repo_url, 'git@github.com:MaxMernikov/astra.git'
set :scm, :git
set :ssh_options, { :forward_agent => true }
set :keep_releases, 1

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w{config/database.yml}

set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment --quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Restart Resque Workers'
  task :restart_workers do
    on roles(:app) do
      within fetch(:deploy_to) + '/current' do
        with rails_env: fetch(:stage) do
          rake 'resque:restart_workers'
        end
      end
    end
  end

  desc 'Restart Resque scheduler'
  task :restart_scheduler do
    on roles(:app) do
      within fetch(:deploy_to) + '/current' do
        with rails_env: fetch(:stage) do
          rake 'resque:restart_scheduler'
        end
      end
    end
  end

  after :finishing, 'deploy:restart'
  # after :finishing, 'deploy:cleanup'
  # after :finishing, 'deploy:restart_workers'
  # after 'deploy:restart_workers', 'deploy:restart_scheduler'

end
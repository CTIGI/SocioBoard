require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/multistage'
require 'mina_sidekiq/tasks'
require 'mina/rvm'
require 'mina/whenever'

set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml', 'config/application.yml', 'db/production.sqlite3')
set :shared_dirs, fetch(:shared_dirs, []).push('log').push('public/uploads').push('tmp/pids').push('tmp/sockets')

task :remote_environment do
  invoke :'rvm:use', 'ruby-2.4.2'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup do
  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/secrets.yml"]
  command %[touch "#{fetch(:shared_path)}/config/application.yml"]

  command %[
    repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
    repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
    if [ -z "${repo_port}" ]; then repo_port=22; fi &&
    ssh-keyscan -p $repo_port -H $repo_host >> ~/.ssh/known_hosts
  ]
end

desc "Deploys the current version to the server."
task deploy: :remote_environment do
  deploy do
    # instance of your project.
    invoke :'git:clone'
  #  invoke :'sidekiq:quiet'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    command "bundle exec rake bower:install"
    command "bundle exec rake bower:resolve"
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'whenever:update'
      invoke :'sidekiq:restart'
      command "touch #{fetch(:current_path)}/tmp/restart.txt"
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

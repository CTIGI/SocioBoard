require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/multistage'
require 'mina/rvm'
require 'mina/npm'
require 'mina_sidekiq/tasks'
require 'mina/whenever'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml',
                    'config/secrets.yml',
                    'log',
                    'config/application.yml',
                    'tmp'
                    ]

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use[ruby-2.2.3-p125@ctigi_auth]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit "shared/config/database.yml"."]

  queue! %[touch "#{deploy_to}/shared/config/application.yml"]
  queue  %[echo "-----> Be sure to edit "shared/config/application.yml"."]

  queue! %[mkdir -p "#{deploy_to}/shared/pids/"]
  queue! %[mkdir -p "#{deploy_to}/shared/log/"]

  queue %[
    repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
    repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
    if [ -z "${repo_port}" ]; then repo_port=22; fi &&
    ssh-keyscan -p $repo_port -H $repo_host >> ~/.ssh/known_hosts
  ]
end

desc "Deploys the current version to the server."
task deploy: :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'sidekiq:quiet'
    invoke :'whenever:clear'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # invoke :'whenever:clear'
    invoke :'npm:install'
    queue! "bundle exec rake bower:install"
    invoke :'rails:db_migrate:force'
    queue! "bundle exec rake bower:resolve"
    invoke :'rails:assets_precompile:force'
    invoke :'deploy:cleanup'

    to :launch do
      queue! "bundle exec whenever -c"

      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
      # invoke :'whenever:update'
      invoke :'sidekiq:restart'
      queue! "bundle exec whenever -w"
    end
  end
end

desc "Seed data to the database"
task :seed => :environment do
  queue "cd #{deploy_to}/#{current_path}/"
  queue "bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  queue  %[echo "-----> Rake Seeding Completed."]
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

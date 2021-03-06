# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{deployer@185.31.161.45}
role :web, %w{deployer@185.31.161.45}
role :db,  %w{deployer@185.31.161.45}

set :rails_env, :staging
set :stage, :staging

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '185.31.161.45', user: 'deployer', roles: %w{web app db}, primary: true 


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
# TODO: ASK about rsa keys, github
 set :ssh_options, {
   keys: %w(/Users/vitaliynesterenko/.ssh/id_rsa),
   forward_agent: true,
   auth_methods: %w(publickey password), 
   port: 2222
 }


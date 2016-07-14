namespace :pg do
  desc "Start Postgres"
  task :start do
    `pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start`
  end

  desc "Stop Postgres"
  task :stop do
    `pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop`
  end
end

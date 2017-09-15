require "rom/sql/rake_task"
require "rom-repository"
require "sqlite3"

namespace :db do
  task :setup do
    ROM.container(:sql, "sqlite://app.db")
  end
end

# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100803173622) do

  create_table "guest_team_memberships", :force => true do |t|
    t.integer  "member_id"
    t.integer  "project_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "guest_team_memberships", ["member_id"], :name => "index_guest_team_memberships_on_member_id"
  add_index "guest_team_memberships", ["project_id"], :name => "index_guest_team_memberships_on_project_id"
  add_index "guest_team_memberships", ["team_id"], :name => "index_guest_team_memberships_on_team_id"
  add_index "guest_team_memberships", ["user_id"], :name => "index_guest_team_memberships_on_user_id"

  create_table "invitations", :force => true do |t|
    t.integer  "inviter_id"
    t.integer  "invitee_id"
    t.string   "email"
    t.string   "hash"
    t.integer  "pending"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.string   "username"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "email"
    t.integer  "last_project_id"
  end

  add_index "members", ["username", "hashed_password"], :name => "index_members_on_username_and_hashed_password"

  create_table "members_organizations", :id => false, :force => true do |t|
    t.integer "member_id"
    t.integer "organization_id"
  end

  add_index "members_organizations", ["member_id"], :name => "index_members_organizations_on_member_id"
  add_index "members_organizations", ["organization_id"], :name => "index_members_organizations_on_organization_id"

  create_table "members_teams", :id => false, :force => true do |t|
    t.integer "member_id"
    t.integer "team_id"
  end

  add_index "members_teams", ["member_id"], :name => "index_members_teams_on_member_id"
  add_index "members_teams", ["team_id"], :name => "index_members_teams_on_team_id"

  create_table "nametags", :force => true do |t|
    t.string   "name"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "relative_position_x"
    t.integer  "relative_position_y"
    t.integer  "member_id"
    t.integer  "user_id"
  end

  add_index "nametags", ["task_id"], :name => "index_nametags_on_task_id"
  add_index "nametags", ["user_id"], :name => "index_nametags_on_user_id"

  create_table "organization_memberships", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "member_id"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "organization_memberships", ["admin"], :name => "index_organization_memberships_on_admin"
  add_index "organization_memberships", ["member_id"], :name => "index_organization_memberships_on_member_id"
  add_index "organization_memberships", ["organization_id"], :name => "index_organization_memberships_on_organization_id"
  add_index "organization_memberships", ["user_id"], :name => "index_organization_memberships_on_user_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_memberships", :force => true do |t|
    t.integer  "project_id"
    t.integer  "member_id"
    t.boolean  "product_owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_memberships", ["member_id"], :name => "index_project_memberships_on_member_id"
  add_index "project_memberships", ["project_id"], :name => "index_project_memberships_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.boolean  "public",          :default => false
    t.string   "public_hash"
  end

  add_index "projects", ["organization_id"], :name => "index_projects_on_organization_id"

  create_table "projects_teams", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "team_id"
  end

  add_index "projects_teams", ["project_id"], :name => "index_projects_teams_on_project_id"
  add_index "projects_teams", ["team_id"], :name => "index_projects_teams_on_team_id"

  create_table "statustags", :force => true do |t|
    t.string   "status"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "color"
    t.integer  "relative_position_x"
    t.integer  "relative_position_y"
  end

  add_index "statustags", ["task_id"], :name => "index_statustags_on_task_id"

  create_table "stories", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "priority"
    t.integer  "size"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",       :default => "not_started"
    t.string   "realid"
    t.integer  "old_priority"
    t.boolean  "release"
  end

  add_index "stories", ["project_id"], :name => "index_stories_on_project_id"
  add_index "stories", ["realid"], :name => "index_stories_on_realid"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "story_id"
    t.text     "description"
    t.string   "status",              :default => "not_started"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "relative_position_x"
    t.integer  "relative_position_y"
    t.string   "color"
  end

  add_index "tasks", ["status"], :name => "index_tasks_on_status"
  add_index "tasks", ["story_id"], :name => "index_tasks_on_story_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "teams", ["organization_id"], :name => "index_teams_on_organization_id"

  create_table "teams_users", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  add_index "teams_users", ["team_id"], :name => "index_teams_users_on_team_id"
  add_index "teams_users", ["user_id"], :name => "index_teams_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "admin",               :default => false, :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "login",                                  :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_project_id"
    t.string   "color"
  end

end

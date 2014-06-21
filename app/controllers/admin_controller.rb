class AdminController < ApplicationController
  def dump
    f = open(File::NULL, 'w')
    sql = Page.all.to_sql_insert({out: f})
    send_data(sql.join("\n"), filename: 'wikin_insert.sql')
  ensure
    f.close
  end
end

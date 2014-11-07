class AdminController < ApplicationController
  def dump
    sio = StringIO.new('', 'r+')
    Page.all.to_sql_insert({out: sio})
    sio.write("SELECT SETVAL('pages_id_seq', #{Page.last.id});")
    sio.rewind
    send_data(sio.read, filename: 'wikin_insert.sql')
  ensure
    sio.close
  end
end

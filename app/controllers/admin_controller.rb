# typed: false
class AdminController < ApplicationController
  def dump
    sio = StringIO.new('', 'r+')
    return redirect_to root_path unless Page.exists?

    Page.all.to_a.to_sql_insert({out: sio})
    sio.write("SELECT SETVAL('pages_id_seq', #{Page.last.id});")
    sio.rewind
    send_data(sio.read.remove("\r"), filename: 'wikin_insert.sql')
  ensure
    sio.close
  end
end

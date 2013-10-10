# -*- coding: utf-8 -*-

require 'fluent-logger'

class RecordsController < ApplicationController
  def new
    @record = Record.new
  end

  def create
    @fluentd = Fluent::Logger::FluentLogger.open('vocabulary',
      host = 'localhost', port = 9999)

    @record = Record.where(tag: record_params["tag"])
    if @record.length >= 1
      set_session_key
    else
      @record = Record.where(key: record_params["key"])
      if @record.length >= 1
        set_session_key
      else
        @record = nil
        session[:key] = nil
        session[:tag] = nil
      end
    end

    if session[:key].nil?
      notice = '該当するユーザーの語彙は見つかりませんでした (そのユーザーはおそらく調査対象ではありません)'
      session[:result] = notice
      @fluentd.post('failure', {
        :key => record_params["key"],
        :tag => record_params["tag"]
      })
      respond_to do |format|
        format.html { redirect_to root_path,
          notice: notice }
        format.json { render json: @record, record: :created, location: @record }
      end
    else
      notice = session[:key] + ' (' + session[:tag] + ')' + ' さんの語彙一覧を表示します'
      session[:result] = notice
      @fluentd.post('success', {
        :key => session[:key],
        :tag => session[:tag]
      })

      respond_to do |format|
        format.html { redirect_to results_path,
          notice: notice }
        format.json { render json: @record, record: :created, location: @record }
      end
    end
  end

  private
    def record_params
      params.require(:record).permit(:key, :tag)
    end

    def set_session_key
      @record.each do |record|
        session[:key] = record.key
        session[:tag] = record.tag
      end
    end

end

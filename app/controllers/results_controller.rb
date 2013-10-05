# -*- encoding: utf-8 -*-

require 'json'

class ResultsController < ApplicationController
  def index
    @values = nil
    @accounts = extract_group(session[:key])

    @record = Record.where(key: session[:key])
    if @record.length >= 1
      @record.each do |record|
        @values = JSON.parse(record.value)
      end
    end
  end

  private
    def extract_group(screen_name)
      array = []
      groups = Group.all
      groups.each do |group|
        hash = JSON.parse(group.json)
        if hash.has_key?(screen_name)
          hash.each do |k, v|
            array << k
          end
        end
      end
      array
    end

end

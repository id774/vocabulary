# -*- encoding: utf-8 -*-

require 'json'

class ResultsController < ApplicationController
  def index
    @values = nil
    @record = Record.where(key: session[:key])
    if @record.length >= 1
      @record.each do |record|
        @values = JSON.parse(record.value)
      end
    end
  end
end

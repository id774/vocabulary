# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + '/../spec_helper'

describe RecordsController, 'Records' do
  fixtures :all

  context 'にアクセスする場合' do
    # login_admin

    def create
      post 'create' , :record => {
        "key"=>"ほげ",
        "value"=>"ふが"
      }
    end

    def update
      post 'update' , :record => {
        "key"=>"ぴよ",
        "value"=>"ほげ"
      }, :id => 6
    end

    describe '一覧表示' do
      it "一覧画面が表示される" do
        get 'index'
        response.should be_success
      end
    end

    describe '詳細' do
      it "詳細画面が表示される" do
        get 'show', :id => 1
        response.should be_success
      end
    end

    describe '新規作成' do
      it "新規作成画面が表示される" do
        get 'new'
        response.should be_success
      end
    end

    describe '編集' do
      it "編集画面が表示される" do
        get 'edit', :id => 1
        response.should be_success
      end
    end

    describe '作成' do
      it "作成処理が正常終了する" do
        create
        response.redirect_url.should eql 'http://test.host/records/7'
        response.header.should have_at_least(1).items
        response.body.should have_at_least(1).items
        flash[:notice].should_not be_nil
        flash[:notice].should eql 'Record was successfully created.'
      end

      it "新規レコードが作成される" do
        create
        record = Record.find(7)
        record.key.should eql "ほげ"
        record.value.should eql "ふが"
      end
    end

    describe '更新' do
      it "更新処理が正常終了する" do
        update
        records = Record.all
        response.redirect_url.should eql 'http://test.host/records/6'
        response.header.should have_at_least(1).items
        response.body.should have_at_least(1).items
        flash[:notice].should_not be_nil
        flash[:notice].should eql 'Record was successfully updated.'
      end

      it "レコードが更新される" do
        update
        record = Record.find(6)
        record.key.should eql "ぴよ"
        record.value.should eql "ほげ"
      end
    end

    describe '削除' do
      it "レコードが削除される" do
        post 'destroy', :id => 1

        response.should be_redirect
        response.redirect_url.should eql 'http://test.host/records'
        response.header.should have_at_least(1).items
        response.body.should have_at_least(1).items
        lambda {
          Record.find(1)
        }.should raise_error ActiveRecord::RecordNotFound
      end
    end
  end

end

# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + '/../spec_helper'

describe RecordsController, 'Records' do
  fixtures :all

  context 'にアクセスする場合' do

    def search_by_key
      post 'create' , :record => {
        "key"=>"todesking",
      }
    end

    describe '語彙抽出器' do
      it "語彙抽出器入力画面が表示される" do
        get 'new'
        response.should be_success
      end
    end

    describe 'スクリーンネームによる検索' do
      it "検索が正常終了する" do
        search_by_key
        response.redirect_url.should eql 'http://test.host/results'
        response.header.should have_at_least(1).items
        response.body.should have_at_least(1).items
        flash[:notice].should_not be_nil
        flash[:notice].should eql "todesking (3752201) さんの語彙一覧を表示します"
      end

    end
  end

end

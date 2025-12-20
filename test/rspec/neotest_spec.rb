# frozen_string_literal: true

# Neotest から実行するためには、cd ./test/rspec が必要
RSpec.describe "基本的なテストの練習" do
  # テスト1: 数値計算のテスト
  describe "算術計算" do
    it "1 + 1 が 2 になること" do
      expect(1 + 1).to eq 2
    end
  end

  # テスト2: 文字列操作のテスト
  describe "文字列の加工" do
    it "文字列を大文字に変換できること" do
      name = "ruby"
      expect(name.upcase).to eq "RUBY"
    end

    it "指定した文字が含まれていること" do
      phrase = "Hello, Bundler!"
      expect(phrase).to include "faaaaaaaa"
    end
  end
end

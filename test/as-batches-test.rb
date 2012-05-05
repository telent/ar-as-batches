require 'active_record'
require 'minitest/autorun'
require 'minitest/spec'
require 'logger'
require_relative '../lib/ar-as-batches'
require_relative './test_helper'

describe ActiveRecord::Relation do
  describe "#as_batches" do
    before do
      # to verify the SQL we're generating
      @out=StringIO.new
      l=Logger.new(@out)
      l.formatter=Logger::Formatter.new
      ActiveRecord::Base.logger=l
      @ds=TestRecord.where("number < 500")
    end
    def queries
      @out.string.split(/\n/).map {|l| m=l.match(/(SELECT .*)$/) and m[0] }
    end

    it "produces queries with offsets 0,200,400 when called with batch size 200 and a query producing 500 rows" do
      count=0
      @ds.as_batches(:batch_size=>200) do |r|
        count+=1
      end
      assert_equal 500,count
      q=queries
      assert_equal 4,q.count
      [0,200,400,500].each_with_index do |offset,i|
        assert_match /LIMIT 200 OFFSET #{offset}/,q[i]
      end
    end    

    it "produces queries with offsets 50,250,450 when given non-zero offsets" do
      @ds.offset(50).as_batches(:batch_size=>200) { |r| true }
      q=queries
      [50,250,450,500].each_with_index do |offset,i|
        assert_match /LIMIT 200 OFFSET #{offset}/,q[i]
      end
    end    

    it "stops early when a limit is given" do
      @ds.limit(300).as_batches(:batch_size=>200) { |r| true }
      q=queries
      assert_match /LIMIT 200 OFFSET 0/,q[0]
      assert_match /LIMIT 100 OFFSET 200/,q[1]
    end

  end
end

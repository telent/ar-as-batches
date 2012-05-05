
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Schema.define do
  drop_table :test_records if table_exists?(:test_records)
  create_table :test_records do |t|
    t.string :name
    t.integer :number
    t.string :extra
    t.timestamps
  end
end

class TestRecord < ActiveRecord::Base
end

now=Time.now
TestRecord.transaction do
  1500.times do |i|
    TestRecord.create :number=>i, :name=>((i%26)+65).chr+" test "+i.to_s, :created_at=>now-i
    $stderr.print "." if (i%100).zero?
  end
end

require 'date'

start = Time.now
#
# Download from http://mikeperham.com/sample_accounts.csv.bz2
#
file = File.open("sample_accounts.csv")
sql_file = File.new("accounts_sql.sql", "w")
sql_file.puts "insert into mailer_account_data (account_number,amount_due, due_on, points, minimum_amount_due, available_credit,
                last_payment, last_payment_received_on, expires_on, balance, apr) values "

idx = 0
sql_line = ""

file.each_line do |line|
  fields = line.split(',')

  account_number = fields[0]
  amount_due = sprintf('%.2f', Float(fields[1]))

  due_on = Date.parse(fields[2], true)
  points = fields[3]
  minimum_amount_due = sprintf('%.2f', Float(fields[4]))
  available_credit = sprintf('%.2f', Float(fields[5]))
  last_payment = sprintf('%.2f', Float(fields[6]))
  last_payment_received_on = Date.parse(fields[7], true)
  expires_on = Date.parse(fields[8], true)
  balance = sprintf('%.2f', Float(fields[9]))
  apr = fields[10]

  sql_file.puts "#{sql_line}(#{account_number},#{amount_due},'#{due_on}',#{points},#{minimum_amount_due},#{available_credit},#{last_payment},'#{last_payment_received_on}','#{expires_on}',#{balance},#{apr})"

  sql_line = ","
end

sql_file.close

duration = (Time.now - start).to_i

puts "Transform time : #{duration.to_s}"

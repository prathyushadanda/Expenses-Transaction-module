module TransactionReports
  class Engine
    def transaction_reports_statement(transactions)
      require 'roo'
      statement_xls = Spreadsheet::Workbook.new
      sheet = statement_xls.create_worksheet :name => 'Transaction Report'
      header = %w[Date Amount Category Type]
      sheet.row(0).default_format = Spreadsheet::Format.new(:weight => :bold)
      header.each_with_index do |label, index|
        sheet[0, index] = label
        sheet.column(index).width = 20
      end
      row_count = 1
      transactions.each do |transaction|
        category = transaction.category
        [transaction.date,transaction.amount,category.source,category.type].each_with_index do |content,index|
          sheet[row_count, index] = content
        end
        row_count += 1
      end
      statement_xls
    end

    def bank_statement(transactions)
      require 'roo'
      statement_xls = Spreadsheet::Workbook.new
      sheet = statement_xls.create_worksheet :name => 'Bank Statement'
      header = %w[Date Income Expense]
      sheet.row(0).default_format = Spreadsheet::Format.new(:weight => :bold)
      header.each_with_index do |label, index|
        sheet[0, index] = label
        sheet.column(index).width = 20
      end
      row_count = 1
      total_income = 0
      total_expense = 0
      transactions.each do |transaction|
        category = transaction.category
        sheet[row_count,0] = transaction.date
        if category.type == 'Income'
          sheet[row_count,1] = transaction.amount
          total_income += transaction.amount
        else
          sheet[row_count,2] = transaction.amount
          total_expense += transaction.amount
        end
        row_count += 1
      end
      sheet[row_count,0] = 'Totals'
      sheet[row_count,1] = total_income
      sheet[row_count,2] = total_expense
      sheet[row_count,3] = total_income - total_expense
      statement_xls
    end
  end
end

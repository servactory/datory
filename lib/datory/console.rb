# frozen_string_literal: true

require "terminal-table"

module Datory
  class Console
    def self.print_table(headings:, rows:, title: nil)
      table = Terminal::Table.new(
        title: title,
        headings: headings,
        rows: rows,
        style: { border_x: "~", border_i: "~" }
      )

      new(table.to_s).print
    end

    def initialize(text)
      @text = text
    end

    def print
      puts @text
    end
  end
end

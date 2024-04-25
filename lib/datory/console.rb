# frozen_string_literal: true

require "terminal-table"

module Datory
  class Console
    def self.print_table(headings, rows)
      table = Terminal::Table.new(
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

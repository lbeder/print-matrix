require 'tco'
require 'rmagick'
require 'pry'

COLORS = {
  0 => 255,
  1 => 0
}.freeze

def to_bool(str)
  return true if str == true || str =~ (/(true|t|yes|y|1)$/i)
  return false if str == false || str.nil? || str == '' || str =~ (/(false|f|no|n|0)$/i)

  raise ArgumentError.new("invalid value for Boolean: \"#{str}\"")
end

def square?(num)
  Math.sqrt(num) % 1 == 0
end

abort('Usage: print.rb MATRIX [invert]') if ARGV.length == 0 || ARGV.length > 2

invert = to_bool(ARGV[1])
matrix = ARGV[0]

abort("Matrix have to be a square matrix (length: #{matrix.length})") unless square?(matrix.length)
width = Math.sqrt(matrix.length).to_i

bits = matrix.chars.each_with_index.map do |element, i|
  element.to_i.tap do |v|
    abort("Element has to be either 0 or 1 (index: #{i}, value: #{v})") unless COLORS.keys.include?(v)
  end
end

bits.each_with_index do |b, i|
  pixel = COLORS[invert ? 1 - b : b]
  print('  '.bg([pixel, pixel, pixel]))

  puts if (i + 1) % width == 0
end

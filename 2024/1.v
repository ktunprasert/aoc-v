// module aoc2024_day1
module main

import os
import arrays

const input_file = '1.txt'
const example_file = '1e.txt'

fn parse_input(filename string) ![][]int {
	content := os.read_file(filename)!
	// dump(content.limit(50) + '...')

	mut input := [][]int{len: 2, init: []int{}}
	for i, n in content.fields().map(it.int()) {
		if i & 1 == 1 {
			input[1] << n
			continue
		}

		input[0] << n
	}

	return input
}

fn abs_diff[T](a T, b T) T {
	if a < b {
		return b - a
	}
	return a - b
}

fn part1(input [][]int) int {
	sorted := input.map(it.sorted())
	return arrays.sum(arrays.group[int](sorted[0], sorted[1]).map(abs_diff(it[0], it[1]))) or { -1 }
}

fn main() {
	mut filename := input_file
	if os.args.len > 1 {
		filename = os.args[1]
	}

	input := parse_input(filename)!
	// dump(input)

	println(part1(input))
}

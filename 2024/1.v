// module aoc2024_day1
module main

import os

const input_file = '1.txt'
const example_file = '1e.txt'

fn parse_input(filename string) ![][]int {
	content := os.read_file(filename)!

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

fn part1(input []int) int {
	return 0
}

fn main() {
	// dump(os.args)
	mut filename := input_file
	if os.args.len > 1 {
		filename = os.args[1]
	}

	input := parse_input(filename)!
	dump(input)
}

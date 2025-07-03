// module aoc2024_day1
module main

import os

const input_file = '1.txt'
const example_file = '1e.txt'

fn parse_input(filename string) ![]int {
	content := os.read_file(filename)!

	return content.fields().map(it.int())
}

fn main() {
	dump(os.args)
	mut filename := input_file
	if os.args.len > 1 {
		filename = os.args[1]
	}

	input := parse_input(filename)!
	dump(input)
}

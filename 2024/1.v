// module aoc2024_day1
module main

import os
import arrays

const input_file = '2024/1.txt'
const example_file = '2024/1e.txt'

fn parse_input(filename string) ![][]int {
	content := os.read_file(filename)!
	// dump(content.limit(50) + '...')

	mut input := [][]int{len: 2, init: []int{}}
	for i, n in content.fields().map(it.int()) {
		input[i & 1] << n
	}

	return input
}

fn abs_diff[T](a T, b T) T {
	if a < b {
		return b - a
	}
	return a - b
}

fn part1(input [][]int) !int {
	sorted := input.map(it.sorted())
	mut sum := 0
	for i in 0 .. sorted[0].len {
		sum += abs_diff(sorted[0][i], sorted[1][i])
	}

	return sum
}

fn part2(input [][]int) !int {
	freq := arrays.map_of_counts(input[1])
	return arrays.sum(input[0].map(it * freq[it]))!
}

fn main() {
	mut filename := input_file
	if os.args.len > 1 {
		filename = os.args[1]
	}

	input := parse_input(filename)!
	// dump(input)

	println(part1(input)!)
	println(part2(input)!)
}

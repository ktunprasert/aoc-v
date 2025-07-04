module main

import os
import arrays

const input_file = '2023/1.txt'
const example_file = '2023/1e.txt'

fn parse_input(filename string) ![][]int {
	mut out := [][]int{}
	for _, line in os.read_lines(filename)! {
		mut tmp := []int{cap: 2}
		for n in line {
			if n.is_digit() {
				tmp << int(n - `0`)
			}
		}

		out << match tmp.len {
			2 { tmp }
			1 { tmp.repeat(2) }
			else { [tmp[0], tmp[tmp.len - 1]] }
		}
	}

	return out
}

fn part1(input [][]int) !int {
	return arrays.sum(input.map(it[0]*10 + it[1]))!
}

// fn part2()

fn main() {
	input := parse_input(if os.args.len > 1 { os.args[1] } else { input_file })!

	println(part1(input)!)
}

module main

import os
import arrays

fn parse_input(line string) ![][]int {
	return arrays.window[int](line.runes().map(|c| if c >= `0` { int(c - `0`) } else { 0 }),
		step: 2
		size: 2
	)
}

fn part1(input []int) !

fn part2(input []int) !

fn main() {
	filename := if os.args.len > 1 { os.args[1] } else { '2024/9.txt' }
	lines := os.read_file(filename)!
	println(lines)
	println(parse_input(lines)!)
}

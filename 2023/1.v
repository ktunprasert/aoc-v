module main

import os
import arrays

const input_file = '2023/1.txt'
const example_file = '2023/1e.txt'

fn parse_input(lines []string) ![][]int {
	mut out := [][]int{}
	for _, line in lines {
		mut tmp := []int{cap: 2}
		for n in line {
			if n.is_digit() {
				tmp << int(n - `0`)
			}
		}

		out << match tmp.len {
			0 { [0, 0] }
			2 { tmp }
			1 { tmp.repeat(2) }
			else { [tmp.first(), tmp.last()] }
		}
	}

	return out
}

fn part1(input [][]int) !int {
	return arrays.sum(input.map(it[0] * 10 + it[1]))!
}

fn parse_input2(lines []string) ![][]int {
	mut out := [][]int{}
	for _, line in lines {
		mut tmp := []int{cap: 2}
		mut i := 0
		for i < line.len {
			n := line[i]
			match true {
				n >= `0` && n <= `9` {
					tmp << int(n - `0`)
					i++
				}
				n == `o` && line.substr_unsafe(i, i + 3) == 'one' {
					tmp << 1
					i += 2
				}
				n == `t` && line.substr_unsafe(i, i + 3) == 'two' {
					tmp << 2
					i += 2
				}
				n == `t` && line.substr_unsafe(i, i + 5) == 'three' {
					tmp << 3
					i += 4
				}
				n == `f` && line.substr_unsafe(i, i + 4) == 'four' {
					tmp << 4
					i += 3
				}
				n == `f` && line.substr_unsafe(i, i + 4) == 'five' {
					tmp << 5
					i += 4
				}
				n == `s` && line.substr_unsafe(i, i + 3) == 'six' {
					tmp << 6
					i += 2
				}
				n == `s` && line.substr_unsafe(i, i + 5) == 'seven' {
					tmp << 7
					i += 4
				}
				n == `e` && line.substr_unsafe(i, i + 5) == 'eight' {
					tmp << 8
					i += 3
				}
				n == `n` && line.substr_unsafe(i, i + 4) == 'nine' {
					tmp << 9
					i += 2
				}
				else {
					i++
				}
			}
		}

		out << match tmp.len {
			0 { [0, 0] }
			2 { tmp }
			1 { tmp.repeat(2) }
			else { [tmp.first(), tmp.last()] }
		}
	}

	return out
}

fn part2(input [][]int) !int {
	return part1(input)!
}

fn main() {
	filename := if os.args.len > 1 { os.args[1] } else { input_file }
	lines := os.read_lines(filename)!

	input1 := parse_input(lines)!
	println(part1(input1)!)

	input2 := parse_input2(lines)!
	println(part2(input2)!)
}

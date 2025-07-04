module main

import os
import arrays

const input_file = '2023/1.txt'
const example_file = '2023/1e.txt'

fn parse_input(lines []string) ![]int {
	mut out := []int{}
	for _, line in lines {
		mut f, mut s := -1, -1
		for n in line {
			if n.is_digit() {
				if f == -1 {
					f = int(n - `0`)
					continue
				}
				s = int(n - `0`)
			}
		}

		out << match s {
			-1 { f * 10 + f }
			else { f * 10 + s }
		}
	}

	return out
}

fn part1(input []int) !int {
	return arrays.sum(input)!
}

fn parse_input2(lines []string) ![]int {
	mut out := []int{}
	for _, line in lines {
		mut f, mut s := -1, -1
		mut i := 0
		for i < line.len {
			n := line[i]
			v := match true {
				n >= `0` && n <= `9` {
					i++
					int(n - `0`)
				}
				n == `o` && line.substr_unsafe(i, i + 3) == 'one' {
					i += 2
					1
				}
				n == `t` && line.substr_unsafe(i, i + 3) == 'two' {
					i += 2
					2
				}
				n == `t` && line.substr_unsafe(i, i + 5) == 'three' {
					i += 4
					3
				}
				n == `f` && line.substr_unsafe(i, i + 4) == 'four' {
					i += 3
					4
				}
				n == `f` && line.substr_unsafe(i, i + 4) == 'five' {
					i += 4
					5
				}
				n == `s` && line.substr_unsafe(i, i + 3) == 'six' {
					i += 2
					6
				}
				n == `s` && line.substr_unsafe(i, i + 5) == 'seven' {
					i += 4
					7
				}
				n == `e` && line.substr_unsafe(i, i + 5) == 'eight' {
					i += 3
					8
				}
				n == `n` && line.substr_unsafe(i, i + 4) == 'nine' {
					i += 2
					9
				}
				else {
					i++
					-1
				}
			}

			if v != -1 {
				if f == -1 {
					f = v
					continue
				}

				s = v
			}
		}

		out << match s {
			-1 { f * 10 + f }
			else { f * 10 + s }
		}
	}

	return out
}

fn part2(input []int) !int {
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

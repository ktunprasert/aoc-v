module main

import os
import arrays

const input_file = '2023/1.txt'
const example_file = '2023/1e.txt'

fn parse_input(filename string) !([][]int, [][]int) {
	mut out1 := [][]int{}
	mut out2 := [][]int{}
	for _, line in os.read_lines(filename)! {
		tmp1 := line.runes().filter(it >= `0` && it <= `9`).map(int(it - `0`))

		mut tmp2 := []int{}
		mut i := 0
		for i < line.len {
			n := line[i]
			match true {
				n >= `0` && n <= `9` {
					tmp2 << int(n - `0`)
					i++
				}
				n == `o` && line.substr_unsafe(i, i + 3) == 'one' {
					tmp2 << 1
					i += 2
				}
				n == `t` && line.substr_unsafe(i, i + 3) == 'two' {
					tmp2 << 2
					i += 2
				}
				n == `t` && line.substr_unsafe(i, i + 5) == 'three' {
					tmp2 << 3
					i += 4
				}
				n == `f` && line.substr_unsafe(i, i + 4) == 'four' {
					tmp2 << 4
					i += 3
				}
				n == `f` && line.substr_unsafe(i, i + 4) == 'five' {
					tmp2 << 5
					i += 4
				}
				n == `s` && line.substr_unsafe(i, i + 3) == 'six' {
					tmp2 << 6
					i += 2
				}
				n == `s` && line.substr_unsafe(i, i + 5) == 'seven' {
					tmp2 << 7
					i += 4
				}
				n == `e` && line.substr_unsafe(i, i + 5) == 'eight' {
					tmp2 << 8
					i += 3
				}
				n == `n` && line.substr_unsafe(i, i + 4) == 'nine' {
					tmp2 << 9
					i += 2
				}
				else {
					i++
				}
			}
		}

		out1 << match tmp1.len {
			0 { [0, 0] }
			2 { tmp1 }
			1 { tmp1.repeat(2) }
			else { [tmp1[0], tmp1[tmp1.len - 1]] }
		}

		out2 << match tmp2.len {
			0 { [0, 0] }
			2 { tmp2 }
			1 { tmp2.repeat(2) }
			else { [tmp2[0], tmp2[tmp2.len - 1]] }
		}
	}

	return out1, out2
}

fn part1(input [][]int) !int {
	return arrays.sum(input.map(it[0] * 10 + it[1]))!
}

fn part2(input [][]int) !int {
	return part1(input)!
}

fn main() {
	input1, input2 := parse_input(if os.args.len > 1 { os.args[1] } else { input_file })!
	println(part1(input1)!)
	println(part2(input2)!)
}

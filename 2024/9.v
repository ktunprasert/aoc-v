module main

import os
import arrays

fn parse_input(line string) !([][]int, int) {
	nums := line.runes().map(|c| if c >= `0` { int(c - `0`) } else { 0 })

	return arrays.window[int](nums,
		step: 2
		size: 2
	), arrays.sum(nums)!
}

fn part1(input [][]int, len int) ! {
	bad_num := -101

	mut disk := []int{len: len, init: bad_num}
	mut id := 0
	mut skip := 0
	mut first_skip := -1
	for code in input {
		for j in 0 .. code[0] {
			disk[skip + j] = id
		}
		if first_skip < 0 {
			first_skip = code[0]
		}

		skip += code[0] + code[1]
		id++
	}

	mut i, mut j := first_skip, disk.len - 1
	for i < j {
		for disk[i] != bad_num {
			i++
		}
		for disk[j] == bad_num {
			j--
		}
		disk[i], disk[j] = disk[j], disk[i]
	}
	// one more time
	disk[i], disk[j] = disk[j], disk[i]

	println('final ${i} ${j}')
	println(disk)
}

fn part2(input []int) !

fn main() {
	filename := if os.args.len > 1 { os.args[1] } else { '2024/9.txt' }
	lines := os.read_file(filename)!
	// println(lines)
	// println(parse_input(lines)!)
	code, len := parse_input(lines)!

	part1(code, len)!
}

module main

import os
import arrays

const bad_num = -101

fn parse_input(line string) ![]int {
	nums := line.runes().map(|c| if c >= `0` { int(c - `0`) } else { 0 })

	mut disk := []int{len: arrays.sum(nums)!, init: bad_num}
	mut id := 0
	mut skip := 0
	mut first_skip := -1

	for i := 0; i < nums.len; i += 2 {
		for j in 0 .. nums[i] {
			disk[skip + j] = id
		}

		if first_skip < 0 {
			first_skip = nums[i]
		}

		skip += nums[i] + nums[i + 1]
		id++
	}

	return disk
}

fn part1(d []int) !u64 {
	mut disk := d.clone()
	mut i, mut j := 0, disk.len - 1
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

	mut total := u64(0)
	for k, n in disk {
		if n == bad_num {
			break
		}
		total += u64(k) * u64(n)
	}

	return total
}

fn part2(d []int) !u64 {
	mut disk := d.clone()
	mut freq := map[int]int{}
	mut empty_freq := map[int]int{}
	mut idx_freq := map[int]int{}
	mut key := 0
	for i, v in disk {
		if v == bad_num {
			empty_freq[key]++
			continue
		}

		key = v
		freq[key]++
		if key !in idx_freq {
			idx_freq[key] = i
		}
	}

	println('empty_freq: ${empty_freq}')
	println('freq: ${freq}')
	println('idx_freq: ${idx_freq}')

	println(disk)

	return 0
}

fn main() {
	filename := if os.args.len > 1 { os.args[1] } else { '2024/9.txt' }
	lines := os.read_file(filename)!
	disk := parse_input(lines)!
	// println(part1(disk)!)
	println(part2(disk)!)
}

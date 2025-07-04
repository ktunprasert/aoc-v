module main

import os
import arrays

fn parse_input(lines []string) ![][][]int {
	mut games := [][][]int{len: lines.len, cap: lines.len}
	for i, game in lines.map(it.after_char(`:`).split('; ').map(it.replace_char(`,`, ` `,
		20).fields())) {
		mut game_ints := [][]int{len: game.len, cap: game.len, init: []int{len: 3, init: 0}}
		for j, colors in game {
			for color in arrays.window(colors, step: 2, size: 2) {
				k := match color[1] {
					'red' { 0 }
					'green' { 1 }
					else { 2 } // blue
				}

				game_ints[j][k] = color[0].int()
			}
		}
		games[i] = game_ints
	}

	return games
}

fn part1(games [][][]int) !int {
	mut total := 0
	for id, game in games {
		if game.all(|it| it[0] <= 12 && it[1] <= 13 && it[2] <= 14) {
			total += id + 1
		}
	}

	return total
}

fn part2(games [][][]int) !int {
	mut total := 0
	for game in games {
		total += arrays.fold(arrays.group[int](...game).map(arrays.max(it)!), 1, |acc, n| n * acc)
	}

	return total
}

fn main() {
	filename := if os.args.len > 1 { os.args[1] } else { '2023/2e.txt' }
	lines := os.read_lines(filename)!
	input := parse_input(lines)!
	println(part1(input)!)
	println(part2(input)!)
}

module main

import os

fn parse_input(lines []string) !

fn part1(input []int) !

fn part2(input []int) !

fn main() {
    filename := if os.args.len > 1 { os.args[1] } else { '2024/9.txt' }
    lines := os.read_lines(filename)!
    dump(lines)
}

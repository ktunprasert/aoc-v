module main

import zztkm.vdotenv
import flag
import os

@[xdoc: 'This is aoc-v, a tool to download Advent of Code data\nUsage: aoc-v <year> <day>']
@[name: 'aoc-v']
struct Config {
mut:
	show_help bool   @[long: help; short: h]
	session   string @[long: session; short: s; xdoc: 'supply session manually, otherwise \$SESSION is read from env']
}

fn main() {
	vdotenv.load()
	mut config, args := flag.to_struct[Config](os.args, skip: 1)!

	mut exit_code := 0
	if args.len != 2 {
		println('Error: You must provide exactly two arguments: year and day.')
		println('Usage: aoc-v <year> <day>\n')
		config.show_help = true
		exit_code = -1
	}

	if config.session == '' {
		config.session = os.getenv('SESSION')
	}

	if config.show_help {
		documentation := flag.to_doc[Config]()!
		println(documentation)
		exit(exit_code)
	}
}

module main

import zztkm.vdotenv
import flag
import os
import net.http

@[xdoc: 'This is aoc-v, a tool to download Advent of Code data\nUsage: aoc-v <year> <day>']
@[name: 'aoc-v']
struct Config {
mut:
	show_help bool   @[long: help; short: h]
	session   string @[long: session; short: s; xdoc: 'supply session manually, otherwise \$SESSION is read from env']
}

const aoc_url = 'https://adventofcode.com'

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

	println('Downloading input for year ${args[0]} and day ${args[1]}...')
	download(args[0], args[1], config.session) or {
		println('Error downloading input: ${err}')
		exit(-1)
	}
	println('Input downloaded successfully.')
}

fn download(year string, day string, session string) ! {
	if !os.is_dir('./inputs') {
		os.mkdir('./inputs')!
	}

	http.download_file_with_cookies('${aoc_url}/${year}/day/${day}/input', './inputs/${year}-${day}.txt',
		{
		'session': session
	})!
}

module main

import zztkm.vdotenv
import flag
import os
import net.http
import log

@[xdoc: 'This is aoc-v, a tool to interact with Advent of Code\nUsage: aoc-v <year> <day>']
@[name: 'aoc-v']
struct Config {
mut:
	show_help bool   @[long: help; short: h]
	session   string @[long: session; short: s; xdoc: 'supply session manually, otherwise \$SESSION is read from env']
	debug     bool   @[long: debug; short: d; xdoc: 'enable debug mode']
	generate  bool   @[long: generate; short: g; xdoc: 'generate a template for the day']
	download  bool   @[long: download; short: D; xdoc: 'download the input file for the day']
}

const aoc_url = 'https://adventofcode.com'

fn main() {
	log.set_level(.info)

	vdotenv.load()
	mut config, args := flag.to_struct[Config](os.args, skip: 1)!
	if config.debug {
		log.set_level(.debug)
	}

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

	if config.generate {
		templ := generate(args[0], args[1])
		if os.exists('./${args[0]}/${args[1]}.v') {
			println('Template file already exists: ./${args[0]}/${args[1]}.v')
		} else {
			println('Generating template file: ./${args[0]}/${args[1]}.v')
			os.write_file('./${args[0]}/${args[1]}.v', templ) or {
				println('Error writing template file: ${err}')
				exit(-1)
			}
		}
	}

	if config.download {
		download(args[0], args[1], config.session) or {
			println('Error downloading input: ${err}')
			exit(-1)
		}
	}

	println('All operations completed successfully.')
	exit(0)
}

fn download(year string, day string, session string) ! {
	if os.exists('./${year}/${day}.txt') {
		println('Input file already exists: ./inputs/${year}-${day}.txt')
		return
	}
	println('Downloading input for year ${year} and day ${day}...')
	defer { println('Input downloaded successfully.') }

	if !os.is_dir('./${year}') {
		println('Creating ${year}/ directory...')
		os.mkdir('./${year}')!
	}

	log.debug('session: ${session}')
	http.download_file_with_cookies('${aoc_url}/${year}/day/${day}/input', './${year}/${day}.txt',
		{
		'session': session
	})!
}

fn generate(year string, day string) string {
	return $tmpl('day.v.tmpl')
}

#!/usr/bin/env ruby

require 'tmpdir'

code = IO.read(ARGV[0])
exit 0 if code.empty?

test = IO.read(ARGV[1]) if ARGV[1]

build_result = nil

Dir.mktmpdir do |dir|
  FileUtils.cd(dir) do
    FileUtils.mkdir_p('solution/src')
    FileUtils.mkdir_p('solution/tests')

    File.open('solution/src/lib.rs', 'w') do |f|
      f.write(code)
    end

    if test
      File.open('solution/tests/test.rs', 'w') do |f|
        f.write(test)
      end
    end

    File.open('solution/Cargo.toml', 'w') do |f|
      f.write(<<~EOF)
        [package]
        name = "solution"
        version = "0.1.0"
        authors = ["Rust Course <fmi@rust-lang.bg>"]
        edition = "2021"

        [dependencies]
      EOF
    end

    build_result = `cd solution && cargo build --tests 2>&1`
  end
end

if build_result =~ /error:/
  puts build_result
  exit 1
else
  exit 0
end

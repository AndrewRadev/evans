require 'open3'

module Language::Rust
  extend self

  def language
    :rust
  end

  def extension
    'rs'
  end

  def can_lint?
    false
  end

  def test_file_pattern
    'test_*.rs'
  end

  def solution_dump(attributes)
    <<-END
// #{attributes[:name]}
// #{attributes[:faculty_number]}
// #{attributes[:url]}

#{attributes[:code]}

// Log output
// ----------
#{attributes[:log].lines.map { |line| "// #{line}".strip }.join("\n")}
    END
  end

  def parse(code)
    TempDir.for('code.rs' => code) do |dir|
      script_path = Rails.root.join('lib/language/rust/syntax_check.rb')
      code_path   = dir.join('code.rs')

      process, output = Open3.popen3(script_path.to_s, code_path.to_s) do |_, stdout, _, thread|
        [thread.value, stdout.read]
      end

      if process.exitstatus.zero?
        [true, nil]
      else
        [false, output]
      end
    end
  end

  def run_tests(test, solution)
    cargo_toml = <<~EOF
      [package]
      name = "solution"
      version = "0.1.0"
      authors = ["Rust Course <fmi@rust-lang.bg>"]
      edition = "2018"

      [dependencies]
    EOF

    test = <<~EOF
      extern crate solution;

      mod solution_test {
        #{test}
      }
    EOF

    TempDir.for({
      'solution/src/lib.rs'             => solution,
      'solution/tests/solution_test.rs' => test,
      'solution/Cargo.toml'             => cargo_toml,
    }) do |dir|
      results = nil

      FileUtils.cd(dir.join('solution')) do
        results = `cargo test --test solution_test 2>&1`.strip
      end

      TestResults.new({
        log:    results,
        passed: results.split("\n").grep(/^test solution_test::test_[a-z0-9_]+ ... ok$/),
        failed: results.split("\n").grep(/^test solution_test::test_[a-z0-9_]+ ... [^o][^k]/),
      })
    end
  end
end

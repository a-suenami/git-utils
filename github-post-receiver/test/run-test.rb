#!/usr/bin/env ruby
#
# Copyright (C) 2010  Kouhei Sutou <kou@clear-code.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

$VERBOSE = true

$KCODE = "u" if RUBY_VERSION < "1.9"

base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
test_unit_dir = File.join(base_dir, "test-unit")
test_unit_lib_dir = File.join(test_unit_dir, "lib")
lib_dir = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")

unless File.exist?(test_unit_dir)
  test_unit_repository = "http://test-unit.rubyforge.org/svn/trunk/"
  system("svn co #{test_unit_repository} #{test_unit_dir}") or exit(false)
end

$LOAD_PATH.unshift(test_unit_lib_dir)

require 'test/unit'

ARGV.unshift("--priority-mode")
ARGV.unshift(File.join(test_dir, "test-unit.yml"))
ARGV.unshift("--config")

$LOAD_PATH.unshift(lib_dir)

$LOAD_PATH.unshift(test_dir)
require 'github-post-receiver-test-utils'

exit Test::Unit::AutoRunner.run(true, test_dir)

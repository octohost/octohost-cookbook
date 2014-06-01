#
# Author:: Seth Vargo <sethvargo@gmail.com>
# Foodcritic:: Rules
#
# Copyright 2012, Seth Vargo, CustomInk, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


rule 'CINK001', 'Missing CHANGELOG in markdown format' do
  tags %w{style changelog cink}
  cookbook do |path|
    filepath = File.join(path, 'CHANGELOG.md')
    unless File.exists?(filepath)
      [ file_match(filepath) ]
    end
  end
end

rule 'CINK002', 'Prefer single-quoted strings' do
  tags %w{style strings cink}
  cookbook do |path|
    recipes  = Dir["#{path}/{#{standard_cookbook_subdirs.join(',')}}/**/*.rb"]
    recipes += Dir["#{path}/*.rb"]
    recipes.collect do |recipe|
      lines = File.readlines(recipe)

      lines.collect.with_index do |line, index|
        # Don't flag if there is a #{} or ' in the line
        if line.match('"(.*)"') &&
          !line.match('\A\s*#') &&
          !line.match('\'(.*)"(.*)"(.*)\'') &&
          !line.match('\`(.*)"(.*)"(.*)\`') &&
          !line.match('"(.*)(#{.+}|\'|\\\a|\\\b|\\\r|\\\n|\\\s|\\\t)(.*)"')
          {
            :filename => recipe,
            :matched => recipe,
            :line => index + 1,
            :column => 0
          }
        end
      end.compact
    end.flatten
  end
end

rule 'CINK003', 'Don\'t hardcode apache user or group' do
  tags %w{bug cink}
  cookbook do |path|
    recipes  = Dir["#{path}/{#{standard_cookbook_subdirs.join(',')}}/**/*.rb"]
    recipes += Dir["#{path}/*.rb"]
    recipes.collect do |recipe|
      lines = File.readlines(recipe)

      lines.collect.with_index do |line, index|
        if line.match('(group|owner)\s+[\\\'\"](apache|www-data|http|www)[\\\'\"]')
          {
            :filename => recipe,
            :matched => recipe,
            :line => index+1,
            :column => 0
          }
        end
      end.compact
    end.flatten
  end
end

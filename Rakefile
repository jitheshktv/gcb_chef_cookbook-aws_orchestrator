desc 'Ruby style guide linter, fails on Error or Warn'

task :rubocop do
  sh 'rubocop --fail-level E'
end

task :foodcritic do
  sh 'foodcritic --epic-fail any .'
end

task default: %w(foodcritic rubocop)

## Prompt:

Create a Ruby script to scan a project's directory, ignoring specific folders and files. For the remaining files generate a JSON file with their structure and content and write to `docs/generated/application-structure.json`

Store a copy of the data in the clipboard

For some files, eg. ` *.rb` I would like you to read the content and put it in the JSON

### Sample Structure
```json
[
  {
    "name": ".rspec_status",
    "type": "file"
  },
  {
    "name": "spec",
    "type": "directory",
    "children": [
      {
        "name": "spec_helper.rb",
        "type": "file",
        "content": "# frozen_string_literal: true\n\nrequire 'pry'\nrequire 'bundler/setup'\nrequire 'simplecov'\n\nSimpleCov.start\n\nrequire 'fli_video'\n\nRSpec.configure do |config|\n  # Enable flags like --only-failures and --next-failure\n  config.example_status_persistence_file_path = '.rspec_status'\n  config.filter_run_when_matching :focus\n\n  # Disable RSpec exposing methods globally on `Module` and `main`\n  config.disable_monkey_patching!\n\n  config.expect_with :rspec do |c|\n    c.syntax = :expect\n  end\nend\n"
      },
      {
        "name": "fli_video_spec.rb",
        "type": "file",
        "content": "# frozen_string_literal: true\n\nRSpec.describe FliVideo do\n  it 'has a version number' do\n    expect(FliVideo::VERSION).not_to be_nil\n  end\nend\n"
      }
    ]
  },
]
```

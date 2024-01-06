## Prompt:

Write a Ruby script to read `docs/feature-list.md` and merge it with content from `.builders/klues/*.klue` files.
Write the result to `docs/generated/features-and-components.md` and copy it to the clipboard.

The Klue files should need a heading: "Klue Components"

The content from each Klue file have a simple heading and be wraped with in a code block with the language set to ruby.

Example:

## Klue Components

Klue Component: `add_episode.klue`

```ruby
# content of add_episode.klue goes here
```

Klue Component: `change_chapter_name.klue`

```ruby
# content of change_chapter_name.klue goes here
```

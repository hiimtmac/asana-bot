# AsanaBot

Command line app for github/asana/slack integration

## Stack

- command line app written in Swift
- packaged using Docker for actions container runtime
- triggered using Github Actions on PR ([see example](./.github/workflows/move-tag.yml))

### Flows

##### PR create/update

- Capture asana tasks in triggering PR body by regex
- Search for section in asana called 'In Progress'
- If section found, move task to section

##### PR ready for review/review requested

- Capture asana tasks in triggering PR body by regex
- Search for section in asana called 'Ready for Review'
- If section found, move task to section

##### PR Merged

- Capture asana tasks in triggering PR body by regex
- Search for section in asana called 'Merged'
- If section found, move task to section
- Notify slack with markdown block of PR body

### Notes

- Uses both GitHub and Asana APIs so possibilities are endless
- Requires no change to current flow
- Can manually move tasks around to other sections and it wont "break"

### TODO

- [ ] Implement Oauth for asana instead of using PAT
- [ ] New swift regex builder when 5.7 is released
- [ ] New date formatters when 5.7 is released
- [ ] Switch formatter to `swift-format` from `swiftformat`

# AsanaBot

Command line app for github/asana/slack integration

### Stack

- command line app written in Swift
- packaged using Docker for actions container runtime
- triggered using Github Actions on PR ([see example](./.github/workflows/move-tag.yml))

##### Packaging

Cutting a release on GitHub will trigger a new docker build and upload to ghcr.io with appropriate tags. Manual build/push can be done with `docker build -t hiimtmac/asana-bot --push .` but GitHub actions needs to run on amd64 based images. If the build is done via GitHub actions that is fine, if you have an arm64 based machine you will need to run `docker buildx build --platform linux/amd64 -t hiimtmac/asana-bot --push .` or use the provided `build.sh` script.

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
- [ ] Change section fetching to batch

# `cimg/template` [![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/cimg-template.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/CircleCI-Public/cimg-template) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/CircleCI-Public/cimg-template/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/images)

Template repository for new CircleCI prototype image repos, each extending CircleCI's [prototype `cimg/base` image](https://github.com/CircleCI-Public/cimg-base).

## Purpose/Usage

To create a new CircleCI prototype image, start a new repository (`CircleCI-Public/cimg-IMAGE_NAME`) from this template.

Populate the `manifests` file according to the instructions that appear there.

_(config.yml instructions go here, etc.)_

Finally, in `README.md` (this file), replace `IMAGE_NAME` with the name of the new image (e.g., `elixir`). Do the same with the string `template` where it appears in either `cimg-template` or `cimg/template`. Then complete this `README` by replacing any text that is specific to this template repository itself (such as this section) with corresponding information about the new image/repository instead.

## Variants

Currently, there is only a Node variant of this image. The Node variant includes the latest LTS version of Node, [installed via the `n` Node version manager](https://github.com/tj/n). To use a different Node version, see [Installing/Activating Node Versions](https://github.com/tj/n#installingactivating-node-versions), or use [CircleCI's Node orb](http://circleci.com/orbs/registry/orb/circleci/node#commands-install-node) to manually install a different version of Node. See below for explanation of specific `-node` (and other) tags.

To create the functionality of a `-browsers` variant, use [CircleCI's `browser-tools` orb](http://github.com/circleci-public/browser-tools-orb/) to install browsers at runtime.

## Tags

### `<IMAGE_NAME-version>-<year>.<month>`, `<IMAGE_NAME-version>-<year>.<month>-node`
Mostly immutable (except in the case of CVEs or severe bugs) monthly release tags for this image and its Node variant. Any new or removed tools from the base image in the last month will be reflected in this image release. For example, the `11.0.4-2019.04`/`11.0.4-2019.04-node` tags would include any changes to this repo/image that occurred in March 2019. Monthly releases are built on the 3rd of every month.

### `<IMAGE_NAME-version>-stable`, `<IMAGE_NAME-version>-stable-node`
Mutable tags representing the most recent monthly release of this image and its Node variant. For example, if today's date was April 15th, 2019, then the `11.0.4-stable`/`11.0.4-stable-node` tags would be aliases for the `11.0.4-2019.04`/`11.0.4-2019.04-node` tags.

### `<IMAGE_NAME-version>-edge`, `<IMAGE_NAME-version>-edge-node`
Mutable tags representing the builds of this image and its Node variant following the most recent successful commit to this repository's `master` branch.

### `latest`
Mutable tag that represents the latest non-Node-variant, vanilla `cimg/IMAGE_NAME` image of any version, functionally duplicating whichever is the most recent Ruby version pushed to either the `edge` or `stable` tags. Anyone calling the `cimg/IMAGE_NAME` image without specifying a tag will get this version of the image.

## Resources

Stub text.

## Development

Working on CircleCI Docker images.

### Adding new `IMAGE_NAME` versions
To add a new version of IMAGE_NAME, add it to the [`versions` array in the `manifests` file](https://github.com/CircleCI-Public/cimg-template/blob/master/manifest#L6), as well as to the [`version` pipeline parameter `enum` at the top of the `config.yml` file](https://github.com/CircleCI-Public/cimg-template/blob/master/.circleci/config.yml#L41).

### Commits to non-master branches
Upon successful commits to non-master branches of this repository, `IMAGE_NAME` versions of this image and its Node variant will be pushed to `ccitest/IMAGE_NAME` for any requisite post-deployment testing. Tags there will represent the branch and commit hash that triggered them. For example, a successful commit to a branch of this repository called `dev` would result in the creation of the following image/tag: `ccitest/IMAGE_NAME:<IMAGE_NAME-version>-dev-${CIRCLE_SHA1:0:7}"`, where `${CIRCLE_SHA1:0:7}"` represents the first six characters of that particular commit hash.

### Patching bugs and vulnerabilities
Monthly release tags can be manually re-published to patch vulnerabilities or severe bugs via a pushing a `git` tag that contains the string `monthly`. This tag will trigger a workflow that will rebuild all current `<IMAGE_NAME-version>-<year>.<month>` and `<IMAGE_NAME-version>-<year>.<month>-node` tags, as well as the `<IMAGE_NAME-version>-stable`, `<IMAGE_NAME-version>-stable-node`, and `latest` alias tags.

### Contributing
We welcome [issues](https://github.com/CircleCI-Public/cimg-template/issues) to and [pull requests](https://github.com/CircleCI-Public/cimg-template/pulls) against this repository!

This image is maintained by the Community & Partner Engineering Team.

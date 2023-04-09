# sveltekit-starter

An opinionated project setup, designed for constructing web applications utilizing [SvelteKit](https://kit.svelte.dev/).

It includes various pre-made configurations, including:

- Sveltekit
- Typescript
- TailwindCSS
- Prettier
- Eslint
- Editorconfig

## Building

[`ghcr.io/maandr/sveltekit-starter`](https://github.com/users/maandr/packages/container/package/sveltekit-starter)

This project targets a containerized runtime environment. The project provides a command `dockerBuild` that builds the application and bakes it into a docker image.

#### Workflows

GitHub Action workflows are preconfigured as follows:

- [![CI](https://github.com/maandr/sveltekit-starter/actions/workflows/ci.yaml/badge.svg)](https://github.com/maandr/sveltekit-starter/actions/workflows/ci.yaml) - Triggers on every pull request and verifies the projects build status and code quality.
- [![CD](https://github.com/maandr/sveltekit-starter/actions/workflows/cd.yaml/badge.svg)](https://github.com/maandr/sveltekit-starter/actions/workflows/cd.yaml) - Triggers on every push or tag to the `main` branch and builds and pushes the docker image to the GitHub Container Registry.

> :exclamation: The `CD` workflow requires the following secrets to be configured in the repository settings:
>
> - `CONTAINER_REGISTRY_PAT`: Personal Access Token for GitHub Container Registry.

## Usage

Here are the key tasks for using the project:

```
# Install project dependencies
pnpm install

# Start the project with hot-reloading
pnpm dev

# Bundle and build the application
pnpm build

# Perform static code analysis on the project's source code
pnpm lint

# Run automated tests for the project
pnpm test

# Build a Docker container to serve the application
pnpm dockerBuild

# Conduct a vulnerability check on the project's dependencies
pnpm audit
```

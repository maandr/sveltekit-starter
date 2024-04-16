# sveltekit-starter

A personalized project skeleton, designed for constructing web applications utilizing [SvelteKit](https://kit.svelte.dev/).

It includes various pre-made configurations, including:

- Sveltekit
- Typescript
- TailwindCSS
- Prettier
- Eslint
- Editorconfig
- Docker

## Building

[`ghcr.io/maandr/sveltekit-starter`](https://github.com/users/maandr/packages/container/package/sveltekit-starter)

This project targets a containerized runtime environment. The project provides a command `dockerBuild` that builds the application and bakes it into a docker image.

### Workflows

GitHub Action workflows are preconfigured as follows:

- [![CI](https://github.com/maandr/sveltekit-starter/actions/workflows/ci.yaml/badge.svg)](https://github.com/maandr/sveltekit-starter/actions/workflows/ci.yaml) - Triggers on every pull request and verifies the projects build status and code quality.
- [![CD](https://github.com/maandr/sveltekit-starter/actions/workflows/cd.yaml/badge.svg)](https://github.com/maandr/sveltekit-starter/actions/workflows/cd.yaml) - Triggers on every push or tag to the `main` branch and builds and pushes the docker image to the GitHub Container Registry.

> :exclamation: The `CD` workflow requires the following secrets to be configured in the repository settings:
>
> - `CONTAINER_REGISTRY_PAT`: Personal Access Token for GitHub Container Registry.

## Development

To run the project on your local machine, you'll need [Node.js](https://nodejs.org/en/) (v21.x) installed. Begin by installing project dependencies using the following command:

```bash
pnpm install
```

To launch the project with hot-reloading, use:

```bash
pnpm dev --open
```

Before committing any changes, you might want to verify code quality and formatting with `pnpm check`, and execute automated tests with `pnpm test`.

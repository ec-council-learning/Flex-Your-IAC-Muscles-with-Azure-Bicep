# Shared Infrastructure as Code (IaC) Artifacts Repository

Welcome to the shared repository for Infrastructure as Code (IaC) artifacts. This repository contains reusable templates, scripts, and configurations for managing infrastructure resources.

## Repository Overview

This repository is designed to centralize and share common IaC artifacts across projects and teams within our organization. It aims to promote code reuse, standardization, and collaboration in managing infrastructure resources on cloud platforms.

## Repository Structure

The repository is structured as follows:

- `Modules/`: Contains Bicep templates and ARM templates for provisioning infrastructure resources.
- `Scripts/`: Includes scripts for automation, configuration, and orchestration tasks.
- `Docs/`: Documentation and guides for using and contributing to the repository.

## Usage Guidelines

When using artifacts from this repository in your projects, follow these guidelines:

1. Clone or reference the `Releases` branch as a submodule in your project.
2. Use relative paths or submodule references to include shared artifacts in your codebase.
3. Avoid making direct changes to artifacts in this branch. Instead, contribute changes through pull requests on the `Feature` branch.

## Versioning and Releases

This repository follows semantic versioning for releases. Each release is tagged with a version number and includes release notes detailing changes and updates.

- Major versions may include breaking changes or significant feature additions.
- Minor versions include new features or enhancements.
- Patch versions contain bug fixes or minor updates.

## Contributing

We welcome contributions to this repository! To contribute, follow these steps:

1. Fork the repository to your GitHub account.
2. Create a new branch for your changes (`git checkout -b feature/new-feature`).
3. Make your changes, commit them (`git commit -m "Add new feature"`), and push the branch to your fork (`git push origin feature/new-feature`).
4. Submit a pull request (PR) from your branch to the main branch of this repository.
5. Collaborate with reviewers and address feedback to get your PR merged.
6. Create another PR from the Main branch to the Release branch and tag using the semantic versioning.

## Support and Contact

For questions, feedback, or support related to this repository, please contact [maintainer-name](mailto:maintainer@example.com).

## Versioning History
|Version Number|Description|
|:---|:---|
|1.0.0|Initial repo created. Added the following templates - VM template for 2016-Datacenter sku, VNet with IP range 10.0.0.0/16, StorageAccount V2|
|1.1.0|Add StorageAccountV2 with Vnet |
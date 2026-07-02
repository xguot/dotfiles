# Codewhale Development Instructions

## Core Philosophy
Write clean, minimalist, and highly maintainable code. Strip away unnecessary visual noise and focus on pure logic. Treat all systems—whether machine learning pipelines, optimization solvers, or high-performance computing deployment scripts—with rigorous engineering standards.

## Commenting and Documentation
* Write all comments, docstrings, and function descriptions in the imperative mood (e.g., "Calculate the gradient penalty", not "Calculates...").
* Avoid all ASCII decorative dividers. Do not use `---`, `===`, `***`, or similar character-based line breaks in comments.
* Keep inline documentation concise and strictly functional.

## Version Control and Commit Standards
* Write commit messages strictly in the imperative mood.
* **Do not use colons (`:`) in commit messages.** Avoid web-style conventional commit formats entirely (e.g., `fix: message` or `fix(scope): message`).
    * **Correct:** `Fix api issue`
    * **Correct:** `Populate system configurations`
    * **Correct:** `Refactor ADMM unrolled solver loop`
    * **Incorrect:** `fix: api issue`
    * **Incorrect:** `fix(scopes): populate system configurations`

### Security Pre-Commit Protocol
* **Mandatory Review:** Before executing any commit, verify absolutely that no sensitive data, API keys, SSH credentials, or environment secrets are staged. 
* Explicitly review all configuration files and HPC deployment scripts in the staging area to ensure security boundaries are maintained prior to pushing.

## Project Architecture (Reference: `kosa`)
Maintain structural consistency with established HPC and computational projects.
* **HPC & Deployment (`ssh/`)**: Keep cluster submission scripts, resource allocation configurations, and SSH utilities isolated, parameterized, and secure. 
* **Machine Learning Frameworks**: Structure deep learning (e.g., PyTorch, JAX) or C++ implementations modularly. Keep model definitions distinct from training pipelines and data ingestion.
* **Optimization Solvers**: Ensure mathematical robustness for components handling complex constraints (e.g., Lagrangian constraints, positive semi-definite guards). Keep solver logic pure, performant, and decoupled from surrounding I/O logic.

## Code Style
* Keep functions small, focused, and single-purpose.
* Prioritize explicit logic over implicit behavior. 
* Design for a minimalist, efficient reading experience that suits a keyboard-driven workflow. Keep line lengths manageable and indentation immaculate.

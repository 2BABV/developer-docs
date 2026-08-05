# 2BA Developer Documentation

Source for [developers.2ba.nl](https://developers.2ba.nl) — built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) and hosted on GitHub Pages.

---

## Local development — Aspire (recommended)

**Prerequisites:** [.NET 10 SDK](https://dotnet.microsoft.com/download) · [Docker Desktop](https://www.docker.com/products/docker-desktop/)

No Python installation required. Aspire builds and runs MkDocs inside a container.

```bash
dotnet run --project 2ba-developer-docs.AppHost
```

The Aspire Dashboard opens in your browser automatically. From there, click the **docs** resource endpoint to open the live documentation site. Any change to `docs/` or `mkdocs.yml` requires restarting the container (Ctrl+C → re-run).

> **macOS Intel users:** replace `osx-arm64` with `osx-x64` in the two `Aspire.Hosting.Orchestration` and `Aspire.Dashboard.Sdk` package references in [2ba-developer-docs.AppHost/2ba-developer-docs.AppHost.csproj](2ba-developer-docs.AppHost/2ba-developer-docs.AppHost.csproj).

---

## Adding or editing content

All documentation lives in the `docs/` folder as Markdown files. The site navigation is defined in `mkdocs.yml` under the `nav:` key.

To add a new page:

1. Create a `.md` file under `docs/`
2. Add it to the `nav:` section in `mkdocs.yml`
3. Commit and push to `main`

---

## Deployment

Deployment is fully automated via GitHub Actions (`.github/workflows/deploy.yml`).

**Trigger:** Every push to `main` queues a deployment. It builds the site and then **waits for manual approval** before publishing to GitHub Pages. This ensures no unreviewed content goes live.

### One-time GitHub setup

#### 1. Create the repository

Create a **private** repository named `developer-docs` under the `2BABV` organisation.

> **GitHub plan requirement:** GitHub Pages for private organisation repositories requires **GitHub Team or Enterprise**. The *source* repo stays private; the *published site* at `developers.2ba.nl` is publicly accessible.

#### 2. Enable GitHub Pages

Go to **Settings → Pages**:

- Source: **GitHub Actions**

#### 3. Configure the deployment environment (approval gate)

Go to **Settings → Environments → `github-pages`**:

- Enable **Required reviewers** and add the people who must approve before a deployment goes live
- Optionally set a **wait timer** (e.g., 10 minutes) as an extra safety window

This is the "block until ready" mechanism — no content reaches the public site without a reviewer clicking **Approve**.

#### 4. Configure the custom domain

Go to **Settings → Pages → Custom domain**:

- Enter `developers.2ba.nl` and save
- GitHub will verify a `CNAME` file is present in the artifact (already included at `docs/CNAME`)

With your DNS provider, add a `CNAME` record:

| Type  | Name        | Value                |
|-------|-------------|----------------------|
| CNAME | developers  | 2babv.github.io      |

Then enable **Enforce HTTPS** once the domain has been verified.

---

## Keeping individual pages in draft

To work on a page privately before including it in the public navigation:

- Simply **omit it from `nav:`** in `mkdocs.yml` — the file won't appear in navigation or search until you add it
- The page will still exist in the `docs/` folder and be version-controlled, but won't be reachable on the site

---

## Branch strategy

| Branch    | Purpose                                   |
|-----------|-------------------------------------------|
| `main`    | Production-ready content; triggers deploy |
| `draft/*` | Work-in-progress pages; no deployment     |

---

## Jenkins

The project can also be built from Jenkins by running:

```bash
pip install -r requirements.txt
mkdocs build --strict
```

The output is in `site/`. Deployment to GitHub Pages from Jenkins is possible via `mkdocs gh-deploy --force`, but the GitHub Actions workflow is the recommended path since it handles the approval gate.

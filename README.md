Paul Kiernan
============

![Lint](https://github.com/paulkiernan/resume/actions/workflows/lint.yaml/badge.svg)

```html
<data>big</data>
```

My resume, typeset in LaTeX, in two flavors from one set of facts:

1. **The character sheet** — a Dungeons & Dragons 5e themed sheet that lives on
   my personal site.
2. **The conventional resume** — a plain, single-column, one-page version for
   recruiter pipelines and ATS parsers.

**Published** (served from `main` by GitHub Pages):

- 📄 **<https://paulkiernan.github.io/resume/resume.pdf>** — the character
  sheet; `pdf/latest.pdf` is a stable alias of the same file (the one
  [paulynomial.com](https://paulynomial.com) points at)
- 📄 **<https://paulkiernan.github.io/resume/resume-standard.pdf>** — the
  conventional resume; `pdf/standard.pdf` is its alias

In the repo itself, [`resume.pdf`](resume.pdf) and
[`resume-standard.pdf`](resume-standard.pdf) at the root are the latest builds.

What's in here
--------------

- [`tex/resume.tex`](tex/resume.tex) — the character sheet's content: quest
  log (experience), ability scores, personality traits, proficiencies
- [`tex/resume-standard.tex`](tex/resume-standard.tex) — the conventional
  resume's content, same facts in plain sections
- [`fonts/dnd-resume.cls`](fonts/dnd-resume.cls) — custom LaTeX class doing the
  heavy lifting: parchment page with a TikZ border, 5e stat-block tapered
  rules, ability-score boxes with modifier bubbles, sidebar tinting
- [`fonts/standard-resume.cls`](fonts/standard-resume.cls) — plain class for
  the conventional resume: one accent color, black text, tight bullets, and a
  `\needs{...}` macro (see below)
- [`fonts/`](fonts/) — vendored open fonts (Lato and Raleway, both under the
  SIL Open Font License) so builds are self-contained
- [`pdf/`](pdf/) — archive of older versions; `pdf/latest.pdf` and
  `pdf/standard.pdf` are symlinks to the root PDFs

Building
--------

The canonical build runs inside Docker for reproducible output and is driven
by [go-task](https://taskfile.dev) (`brew install go-task`):

```sh
task                   # build image, compile both PDFs in a container
task preview           # build and open the character sheet
task preview-standard  # build and open the conventional resume
task lint              # lint the TeX sources with chktex, in Docker
task chktex            # same, with a chktex already on the host
```

For quick local iteration with a host TeX install (e.g.
[TinyTeX](https://yihui.org/tinytex/)): `task --watch compile` or
`task --watch compile-standard`

Good to know:

- The build runs **two xelatex passes** — the TikZ `remember picture`
  overlays (page border, sidebar tint) need the second pass to anchor to the
  page. One pass leaves the border floating mid-page.
- **Unfilled facts are loud.** In the conventional resume, `\needs{...}`
  renders as bold red `[FILL: ...]` inline, so a draft with a missing number
  or link cannot be sent by accident. Grep for `\needs` before sharing.
- Lint is plain [chktex](https://www.nongnu.org/chktex/), locally and in CI;
  any warning fails the run. Silence a single false positive with a
  `% chktex N` comment on that line.
- The layout is built to be **machine-readable despite the theme**: the main
  column precedes the sidebar in extraction order, so ATS parsers read
  name → contact → experience → skills.

Looking to chat? Send a line to [hi@paulynomial.com](mailto:hi@paulynomial.com?subject=Hi)

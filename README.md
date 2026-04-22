Paul Kiernan
============

![Super-Linter](https://github.com/paulkiernan/resume/workflows/Super-Linter/badge.svg)

```html
<data>big</data>
```

My resume, typeset in LaTeX as a Dungeons & Dragons 5e character sheet.

**[📄 resume.pdf](resume.pdf)** — the latest build, straight from the repo root.

What's in here
--------------

- [`tex/resume.tex`](tex/resume.tex) — the content: quest log (experience),
  ability scores, personality traits, proficiencies
- [`fonts/dnd-resume.cls`](fonts/dnd-resume.cls) — custom LaTeX class doing the
  heavy lifting: parchment page with a TikZ border, 5e stat-block tapered
  rules, ability-score boxes with modifier bubbles, sidebar tinting
- [`fonts/`](fonts/) — vendored open fonts (Lato, Raleway; see
  [NOTICE.md](NOTICE.md)) so builds are self-contained
- [`pdf/`](pdf/) — archive of older versions; `pdf/latest.pdf` is a symlink
  to the root `resume.pdf`

Building
--------

The canonical build runs inside Docker for reproducible output and is driven
by [go-task](https://taskfile.dev) (`brew install go-task`):

```sh
task            # build image, compile the PDF in a container, publish output
task preview    # build and open the PDF
task lint       # run the TeX linter
```

For quick local iteration with a host TeX install (e.g.
[TinyTeX](https://yihui.org/tinytex/)): `task --watch compile`

Good to know:

- The build runs **two xelatex passes** — the TikZ `remember picture`
  overlays (page border, sidebar tint) need the second pass to anchor to the
  page. One pass leaves the border floating mid-page.
- The layout is built to be **machine-readable despite the theme**: the main
  column precedes the sidebar in extraction order, so ATS parsers read
  name → contact → experience → skills.

Looking to chat? Send a line to [hi@paulynomial.com](mailto:hi@paulynomial.com?subject=Hi)

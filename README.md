Paul Kiernan
============

![Lint](https://github.com/paulkiernan/resume/actions/workflows/lint.yaml/badge.svg)

```html
<data>big</data>
```

My resume, typeset in LaTeX: one page, single column, styled to match
[paulynomial.com](https://paulynomial.com) and plain enough for ATS parsers.

**Published** (served from `main` by GitHub Pages):
📄 **<https://paulkiernan.github.io/resume/resume.pdf>**. `pdf/latest.pdf` is a
stable alias of the same file (the one paulynomial.com points at).

What's in here
--------------

- [`tex/resume.tex`](tex/resume.tex) — the content
- [`fonts/resume.cls`](fonts/resume.cls) — the LaTeX class: Space Mono name,
  headings and dates, Lato body, black and greys only, the site's black left
  rule beside the header, a label grid for skills and education, and a
  `\needs{...}` macro (see below)
- [`fonts/`](fonts/) — vendored open fonts (Lato and Space Mono, both under the
  SIL Open Font License) so builds are self-contained
- [`pdf/`](pdf/) — archive of older versions; `pdf/latest.pdf` is a symlink to
  the root `resume.pdf`

Building
--------

The canonical build runs inside Docker for reproducible output and is driven
by [go-task](https://taskfile.dev) (`brew install go-task`):

```sh
task          # build image, compile resume.pdf in a container
task preview  # build and open it
task lint     # lint the TeX source with chktex, in Docker
task chktex   # same, with a chktex already on the host
```

For quick local iteration with a host TeX install (e.g.
[TinyTeX](https://yihui.org/tinytex/)): `task --watch compile`

Good to know:

- **Unfilled facts are loud.** `\needs{...}` renders as bold red
  `[FILL: ...]` inline, so a draft with a missing number or link cannot be
  sent by accident. Grep for `\needs` before sharing.
- **It must fit one page.** The build output says `Output written on
  resume.pdf (N pages)`; anything but 1 means trim content or spacing.
- Lint is plain [chktex](https://www.nongnu.org/chktex/), locally and in CI;
  any warning fails the run. Silence a single false positive with a
  `% chktex N` comment on that line.

Looking to chat? Send a line to [hi@paulynomial.com](mailto:hi@paulynomial.com?subject=Hi)

# ches-2026-xmss

Initialize the CryptoBib bibliography before building:

```sh
git submodule update --init cryptobib
make
```

The slides cite entries directly from `cryptobib/crypto.bib`, using the
venue abbreviations in `cryptobib/abbrev3.bib`.

# vim-spec

Spec runner for Vim. Run Rspec and Mocha tests straight from Vim.

Inspired by [thoughtbot/vim-rspec](https://github.com/thoughtbot/vim-rspec) and
[geekjuice/vim-mocha](https://github.com/geekjuice/vim-mocha).

A hacked-up marriage between vim-rspec and vim-mocha. Determines whether to run
`Mocha` or `Rspec` based on the spec's filetype. Allows for the same mapping to
be used for all tests.

__Example__: Calling `<leader>t` in a Javascript file will call `mocha`. The
same mapping can be used in a Coffeescript file and call `mocha` with the
Coffeescript compiler. And of course, calling it from a Ruby file will invoke
`rspec`.



__Only need Mocha? Take a look at
[vim-mocha](https://github.com/geekjuice/vim-mocha)!__

## Installation

Using [vundle](https://github.com/gmarik/vundle):

```vim
Bundle 'geekjuice/vim-spec'
```

If using zsh on OS X it may be necessary to run move `/etc/zshenv` to `/etc/zshrc`.


Using [pathogen](https://github.com/tpope/vim-pathogen)

```sh
cd ~/.vim/bundle
git clone git://github.com/geekjuice/vim-spec.git
```

## Example of key mappings

```vim
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
```

## Configuration

Like [thoughtbot/vim-rspec](https://github.com/thoughtbot/vim-rspec), the
following variables can be overwritten for custom spec commands:

* `g:rspec_command`
* `g:mocha_js_command`
* `g:mocha_coffee_command`

Examples:

```vim
let g:rspec_command = "!rspec --drb {spec}"
let g:mocha_js_command = "!mocha --recursive --no-colors {spec}"
let g:mocha_coffee_command = "!mocha -b --compilers coffee:coffee-script{spec}"

" Using test runners
let g:rspec_command = "Dispatch zeus rspec {spec}"
let g:mocha_coffee_command = "!cortado {spec}" "See geekjuice/vim-mocha
```

## Notes/Issues

* Default spec command fallbacks to the dominant spec filetype i.e. Ruby, JS,
  Coffee in the current directory. Future update will look for {spec|test}
  directories rather than search the whole parent tree

* Assertions with no name i.e. no attribute for `it` in mocha will fail if
  trying to call nearest test `RunNearestSpec` as it depends on `it` having a
  value


## Credits

[thoughtbot/vim-rspec](https://github.com/thoughtbot/vim-rspec)

[geekjuice/vim-mocha](https://github.com/geekjuice/vim-mocha)

## License

vim-spec is released under the [MIT License](LICENSE).

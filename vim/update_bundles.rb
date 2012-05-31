#!/usr/bin/env ruby

git_bundles = [ 
  "http://github.com/tpope/vim-fugitive.git",
	"https://github.com/tpope/vim-endwise.git",
	"https://github.com/tpope/vim-pastie.git",
  "https://github.com/tpope/vim-surround.git",
  "https://github.com/tpope/vim-rails.git",
  "https://github.com/tpope/vim-haml.git",
  "https://github.com/tpope/vim-markdown.git",
	"https://github.com/tpope/vim-ragtag.git",
  "https://github.com/tpope/vim-repeat.git",
  "https://github.com/tpope/vim-cucumber.git",
	"https://github.com/tpope/vim-rake.git",
	"https://github.com/tpope/vim-bundler.git",
	"https://github.com/scrooloose/nerdcommenter.git",
	"https://github.com/scrooloose/nerdtree.git",
	"https://github.com/tpope/vim-abolish.git",
	"https://github.com/cakebaker/scss-syntax.vim.git",
	"https://github.com/scrooloose/syntastic.git",
  "https://github.com/timcharper/textile.vim.git",
	"https://github.com/tpope/vim-unimpaired.git",
  "https://github.com/vim-ruby/vim-ruby.git",
	"https://github.com/tsaleh/vim-matchit.git",
	"https://github.com/othree/html5.vim.git",
	"https://github.com/astashov/vim-ruby-debugger.git",
	"https://github.com/nelstrom/vim-textobj-rubyblock.git",
	"https://github.com/kana/vim-textobj-user.git",
	"https://github.com/fholgado/minibufexpl.vim.git",
	"https://github.com/rygwdn/ultisnips.git",
	"https://github.com/MarcWeber/vim-addon-mw-utils.git",
	"https://github.com/tomtom/tlib_vim.git",
	"https://github.com/majutsushi/tagbar.git",
	"https://github.com/sukima/xmledit.git",
	"https://github.com/DataWraith/auto_mkdir.git",
	"https://github.com/jpo/vim-railscasts-theme.git",
	"https://github.com/tpope/vim-vividchalk.git",
	"https://github.com/rson/vim-conque.git",
	"https://github.com/vim-scripts/AutoComplPop.git",
	"https://github.com/godlygeek/tabular.git",
	"https://github.com/ervandew/lookup.git",
	"https://github.com/ervandew/regex.git",
	"https://github.com/ervandew/archive.git",
  "https://github.com/tsaleh/vim-align.git",
	"https://github.com/vim-scripts/Decho.git",
	"https://github.com/vim-scripts/bufexplorer.zip.git",
	"https://github.com/vim-scripts/jQuery.git",
	"https://github.com/mattn/gist-vim.git",
	"https://github.com/henrik/vim-indexed-search.git",
	"https://github.com/vim-scripts/FuzzyFinder.git",
	"https://github.com/vim-scripts/genutils.git",
	"https://github.com/vim-scripts/gtags.vim.git",
	"https://github.com/vim-scripts/javacomplete.git",
	"https://github.com/vim-scripts/L9.git",
	"https://github.com/vim-scripts/scratch.vim.git",
	#"https://github.com/hsitz/PyScratch.git",
	"https://github.com/vim-scripts/taglist.vim.git",
	"https://github.com/framallo/taskwarrior.vim.git",
	"https://github.com/vim-scripts/vilight.vim.git",
	"https://github.com/kchmck/vim-coffee-script.git",
	#"https://github.com/vim-scripts/perforce.git",
	"https://github.com/csexton/jekyll.vim.git",
]

vim_org_scripts = [
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

puts "Trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "  Unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
  puts "  Downloading #{name}"
  local_file = File.join(name, script_type, "#{name}.vim")
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
end

